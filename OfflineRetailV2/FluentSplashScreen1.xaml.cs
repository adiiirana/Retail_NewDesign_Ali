using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using DevExpress.Xpf.Core;

namespace OfflineRetailV2
{
    /// <summary>
    /// Interaction logic for FluentSplashScreen1.xaml
    /// </summary>
    public partial class FluentSplashScreen1 : DevExpress.Xpf.Core.SplashScreenWindow
    {
        public FluentSplashScreen1()
        {
            InitializeComponent();

            // new design: sliding loading bar, started in code so it runs as soon as the splash exists
            var slide = new System.Windows.Media.Animation.DoubleAnimation(-84, 220, TimeSpan.FromSeconds(1.5))
            {
                RepeatBehavior = System.Windows.Media.Animation.RepeatBehavior.Forever,
                EasingFunction = new System.Windows.Media.Animation.SineEase { EasingMode = System.Windows.Media.Animation.EasingMode.EaseInOut }
            };
            barMove.BeginAnimation(TranslateTransform.XProperty, slide);
        }
    }
}
