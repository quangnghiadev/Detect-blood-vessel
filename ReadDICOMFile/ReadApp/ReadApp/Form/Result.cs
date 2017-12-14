using ReadApp.Helper;
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
        public Result()
        {
            InitializeComponent();
            labelFrameNumber.Text = MainForm.currentFrame.ToString();
            imagePanelSource.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\source.tif");
        }

        private void Result_Load(object sender, EventArgs e)
        {
            MatlabHelper.shared.DetectVessel();
            imagePanelResult.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\result.tif");
        }

        private void buttonAccurary_Click(object sender, EventArgs e)
        {
            var accuracy = new Accuracy();
            accuracy.ShowDialog();
        }
    }
}
