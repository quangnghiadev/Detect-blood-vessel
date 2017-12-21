using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ReadApp.Helper;
using System.IO;

namespace ReadApp
{
    public partial class Accuracy : Form
    {
        public delegate void CallbackFunc();
        private double accuracyRatio = 0.0;
        private string resultFile;

        public Accuracy(string fileName)
        {
            this.resultFile = fileName;
            InitializeComponent();
            imagePanelResult.Image = MainForm.LoadImageFromPath(Application.StartupPath + "\\matlab\\data\\" + resultFile);
            File.Copy(Application.StartupPath + "\\matlab\\data\\" + resultFile, Application.StartupPath + "\\matlab\\data\\result.tif",true);
        }

        private void Accuracy_Load(object sender, EventArgs e)
        {

        }

        private void imagePanelGroundTruth_Click(object sender, EventArgs e)
        {
            if (buttonOpenGroundTruth.Visible == false)
            {
                buttonOpenGroundTruth_Click(sender, e);
            }
        }

        private void SetAccuracyRatio()
        {
            Cursor.Current = Cursors.Default;
            labelAccuracy.Text = String.Format("{0:0.00}", accuracyRatio) + "%";
        }

        private void buttonOpenGroundTruth_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                Cursor.Current = Cursors.WaitCursor;
                buttonOpenGroundTruth.Visible = false;
                var desFilePath = Application.StartupPath + "\\matlab\\data\\groundtruth.jpg";/* + Path.GetExtension(openFileDialog1.FileName)*/
                if (File.Exists(desFilePath))
                {
                    File.Delete(desFilePath);
                }
                File.Copy(openFileDialog1.FileName, desFilePath);
                imagePanelGroundTruth.Image = MainForm.LoadImageFromPath(openFileDialog1.FileName);

                System.Threading.Thread t = new System.Threading.Thread(() => {
                    accuracyRatio = MatlabHelper.shared.CalculateAccurary();
                    this.Invoke(new CallbackFunc(SetAccuracyRatio));
                });
                t.Start();
            }
        }
    }
}
