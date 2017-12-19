using ReadApp.Helper;
using ReadApp.Manager;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
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
        private string sourceFileName;
        private string resultFileName;
        public Result()
        {
            InitializeComponent();
            int[] arr = Enumerable.Range(1, DICOMManager.shared.FrameCount + 1).ToArray();
            comboBoxFrameNumber.DataSource = arr;
            comboBoxFrameNumber.SelectedIndex = 1;
            sourceFileName = DICOMManager.shared.FileName + "_" + MainForm.currentFrame.ToString() + ".tif";
            resultFileName = "result_" + sourceFileName;
            labelFrameNumber.Text = MainForm.currentFrame.ToString();
            imagePanelSource.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\" + sourceFileName);
        }

        private void Result_Load(object sender, EventArgs e)
        {
            Detect();
        }

        private void Detect(bool forceRun = false)
        {
            beginTime = DateTime.Now;
            if (forceRun)
            {
                System.Threading.Thread t = new System.Threading.Thread(() => {
                    MatlabHelper.shared.DetectVessel(sourceFileName);
                    endTime = DateTime.Now;
                    this.Invoke(new CallbackFunc(SetResultImage));
                });
                t.Start();
            }
            else
            {
                if (!File.Exists(Application.StartupPath + "\\matlab\\data\\" + resultFileName))
                {
                    System.Threading.Thread t = new System.Threading.Thread(() => {
                        MatlabHelper.shared.DetectVessel(sourceFileName);
                        endTime = DateTime.Now;
                        this.Invoke(new CallbackFunc(SetResultImage));
                    });
                    t.Start();
                }
                else
                {
                    imagePanelResult.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\" + resultFileName);
                    labelTime.Text = "Extracted output";
                }
            }
        }

        private void SetResultImage()
        {
            imagePanelResult.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\" + resultFileName);
            TimeSpan ts = (endTime - beginTime);
            labelTime.Text = (ts.Seconds + ts.Milliseconds*0.001).ToString() + " s";
        }

        private void buttonAccurary_Click(object sender, EventArgs e)
        {
            var accuracy = new Accuracy(resultFileName);
            accuracy.ShowDialog();
        }

        private void comboBoxFrameNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var currentFrame = Convert.ToInt32(comboBoxFrameNumber.SelectedValue);
            //DICOMManager.shared.ExportFrame(currentFrame - 1, ImageFormat.Tiff, Application.StartupPath + "\\matlab\\data\\source.tif");
        }

        private void buttonForceDetect_Click(object sender, EventArgs e)
        {
            Detect(true);
        }

        private void buttonSave_Click(object sender, EventArgs e)
        {
            saveFileDialog1.Filter = "png(*.png)| *.png; |Bitmap(*.bmp)| *.bmp; | JPG(*.jpg)| *.jpg; | TIFF(*.tif)| *.tif";
            if (saveFileDialog1.ShowDialog() == DialogResult.OK)
            {
                var desPath = saveFileDialog1.FileName;
                var sourcePath = Application.StartupPath + "\\matlab\\data\\" + resultFileName;
                File.Copy(sourcePath, desPath);
            }
        }
    }
}
