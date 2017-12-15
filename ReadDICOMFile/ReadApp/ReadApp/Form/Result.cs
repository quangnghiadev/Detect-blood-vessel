using ReadApp.Helper;
using ReadApp.Manager;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReadApp
{
    public partial class Result : Form
    {
        public delegate void CallbackFunc();
        private DateTime beginTime;
        private DateTime endTime;
        public Result()
        {
            InitializeComponent();
            labelFrameNumber.Text = MainForm.currentFrame.ToString();
            imagePanelSource.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\source.tif");
        }

        private void Result_Load(object sender, EventArgs e)
        {
            beginTime = DateTime.Now;
            System.Threading.Thread t = new System.Threading.Thread(() => {
                MatlabHelper.shared.DetectVessel();
                endTime = DateTime.Now;
                this.Invoke(new CallbackFunc(SetResultImage));
            });
            t.Start();
        }

        private void SetResultImage()
        {
            imagePanelResult.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\result.tif");
            TimeSpan ts = (endTime - beginTime);
            labelTime.Text = (ts.Seconds + ts.Milliseconds*0.001).ToString() + " s";
        }

        private void buttonAccurary_Click(object sender, EventArgs e)
        {
            var accuracy = new Accuracy();
            accuracy.ShowDialog();
        }
    }
}
