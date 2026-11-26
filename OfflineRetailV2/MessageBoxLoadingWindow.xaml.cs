using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace OfflineRetailV2
{
    /// <summary>
    /// Interaction logic for MessageBoxLoadingWindow.xaml
    ///
    /// New design: the loading card is shown while the UI thread is busy (login, opening the POS, imports), so a
    /// window on that thread could never animate. The instance callers hold is now a proxy: Show / Hide / Close /
    /// SetText forward to a twin window that lives on its own UI thread, where the progress bar keeps moving.
    /// </summary>
    public partial class MessageBoxLoadingWindow : Window
    {
        private readonly bool _isWorker;              // true for the twin window on the loader thread
        private MessageBoxLoadingWindow _worker;      // proxy side: the twin window
        private Dispatcher _workerDispatcher;
        private string _caption;
        private string _text;

        public MessageBoxLoadingWindow()
        {
            InitializeComponent();
            InitCard();
            Set();
        }

        public MessageBoxLoadingWindow(bool BookerCall)
        {
            InitializeComponent();
            InitCard();
        }

        private MessageBoxLoadingWindow(bool BookerCall, bool worker) : this(BookerCall)
        {
            _isWorker = worker;
        }

        // rounded card corners + sliding progress bar (started in code so it never depends on a Loaded trigger)
        private void InitCard()
        {
            cardBody.SizeChanged += (s, e) => cardBody.Clip = new RectangleGeometry(new Rect(cardBody.RenderSize), 18, 18);
            var slide = new DoubleAnimation(-76, 200, TimeSpan.FromSeconds(1.5))
            {
                RepeatBehavior = RepeatBehavior.Forever,
                EasingFunction = new SineEase { EasingMode = EasingMode.EaseInOut }
            };
            barMove.BeginAnimation(TranslateTransform.XProperty, slide);
        }

        #region proxy -> loader thread

        private void EnsureWorker()
        {
            if (_worker != null && _workerDispatcher != null && !_workerDispatcher.HasShutdownStarted) return;

            var ready = new ManualResetEventSlim(false);
            string caption = _caption, text = _text;
            var thread = new Thread(() =>
            {
                try
                {
                    var w = new MessageBoxLoadingWindow(true, true);
                    if (text != null) w.ApplyText(caption, text);
                    else w.Set();
                    w.Closed += (s, e) => Dispatcher.CurrentDispatcher.BeginInvokeShutdown(DispatcherPriority.Background);
                    _worker = w;
                    _workerDispatcher = w.Dispatcher;
                }
                finally
                {
                    ready.Set();
                }
                Dispatcher.Run();
            });
            thread.SetApartmentState(ApartmentState.STA);
            thread.IsBackground = true;
            thread.Name = "LoadingCard";
            thread.Start();
            ready.Wait(3000);
        }

        private void OnWorker(Action<MessageBoxLoadingWindow> action)
        {
            var w = _worker;
            var d = _workerDispatcher;
            if (w == null || d == null || d.HasShutdownStarted) return;
            d.BeginInvoke(new Action(() => { try { action(w); } catch { } }));
        }

        public new void Show()
        {
            if (_isWorker) { base.Show(); return; }
            EnsureWorker();
            OnWorker(w => w.Show());
        }

        public new void Hide()
        {
            if (_isWorker) { base.Hide(); return; }
            OnWorker(w => w.Hide());
        }

        public new void Close()
        {
            if (_isWorker) { base.Close(); return; }
            OnWorker(w => w.Close());
            _worker = null;
            _workerDispatcher = null;
        }

        #endregion

        public void SetText(string caption, string text)
        {
            if (_isWorker) { ApplyText(caption, text); return; }
            _caption = caption;
            _text = text;
            ApplyText(caption, text);
            OnWorker(w => w.ApplyText(caption, text));
        }

        private void ApplyText(string caption, string text)
        {
            Title = caption;
            ContentTextBlock.Text = text;
            Set();
        }

        public void Set(/*string text, string caption, MessageBoxButton button, MessageBoxImage image*/)
        {
            int len = (ContentTextBlock.Text ?? "").Length;
            double size;
            if (len <= 69) size = 15.0;
            else if (len <= 90) size = 14.5;
            else if (len <= 110) size = 14.0;
            else if (len <= 130) size = 13.5;
            else if (len <= 150) size = 13.0;
            else size = 12.5;
            ContentTextBlock.SetValue(FontSizeProperty, size);
        }
    }
}
