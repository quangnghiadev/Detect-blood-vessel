using System.Windows.Forms;
using ReadApp.Manager;
using System.Data;
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

namespace ReadApp
{
    public partial class MainForm : Form
    {
        private Timer myTimer = new Timer();
        private int currentFrame;
        private string defaultImageFormat = "." + ImageFormat.Tiff.ToString();
        private int totalFrame;
        public MainForm()
        {
            InitializeComponent();
            myTimer.Tick += new EventHandler(TimerEventProcessor);
        }

        #region Media Player

        private string getTempFolderPath()
        {
            return Application.StartupPath + "\\data\\" + DICOMManager.shared.FileName + "\\";
        }

        private void InitMediaPlayer()
        {
            currentFrame = 1;
            trackBar1.Value = 10;
            totalFrame = DICOMManager.shared.getNumberOfFrame();
            tbFrame.Text = currentFrame.ToString();
            labelTotalFame.Text = "/" + totalFrame;
            myTimer.Stop();
            //totalFrame = (from file in Directory.EnumerateFiles(getTempFolderPath(), "*" + defaultImageFormat, SearchOption.AllDirectories)
            //                select file).Count();
            // Sets the timer interval to 5 seconds.
            
            myTimer.Interval = 80;
            myTimer.Start();
            myTimer.Enabled = false;
            imagePanel1.Image = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
        }

        private void TimerEventProcessor(Object myObject, EventArgs myEventArgs)
        {
            myTimer.Stop();
            // Displays a message box asking whether to continue running the timer.
            myTimer.Enabled = true;
            //pictureBoxMain.BackgroundImage = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
            tbFrame.Text = currentFrame.ToString();
            currentFrame += 1;
            currentFrame = currentFrame > totalFrame ? 1 : currentFrame;
        }

        private void btnPlay_Click(object sender, EventArgs e)
        {
            myTimer.Enabled = !myTimer.Enabled;
            btnPlay.Image = !myTimer.Enabled ? Properties.Resources.play_button : Properties.Resources.pause;
        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            currentFrame = 1;
            pause();
            //pictureBoxMain.BackgroundImage = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            if (currentFrame == totalFrame)
            {
                currentFrame = 1;
            }
            else
            {
                currentFrame += 1;
            }
            pause();
            //pictureBoxMain.BackgroundImage = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
        }

        private void btnPrevious_Click(object sender, EventArgs e)
        {
            if (currentFrame == 1)
            {
                currentFrame = totalFrame;
            } else
            {
                currentFrame -= 1;
            }
            
            pause();
            //pictureBoxMain.BackgroundImage = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
        }

        private void pause()
        {
            myTimer.Enabled = false;
            btnPlay.Image = Properties.Resources.play_button;
            tbFrame.Text = currentFrame.ToString();
        }

        private void tbFrame_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                currentFrame = Int32.Parse(tbFrame.Text);
                if (currentFrame == 0)
                {
                    currentFrame = 1;
                }
                else if (currentFrame > totalFrame)
                {
                    currentFrame = totalFrame;
                }
                pause();
                //pictureBoxMain.BackgroundImage = LoadImageFromPath(getTempFolderPath() + currentFrame + defaultImageFormat);
            }
        }

        private void tbFrame_TextChanged(object sender, EventArgs e)
        {

        }

        private void tbFrame_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private Bitmap LoadImageFromPath(string path)
        {
            Bitmap img;
            using (var bmpTemp = new Bitmap(path))
            {
                img = new Bitmap(bmpTemp);
            }
            return img;
        }

        #endregion

        private void MainForm_Load(object sender, System.EventArgs e)
        {

        }

        private void buttonOpen_Click(object sender, System.EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                DICOMManager.shared.Read(openFileDialog1.FileName, openFileDialog1.SafeFileName);
                FillPatientTagToGridView();
                FillAllTagToGridView();
                DICOMManager.shared.ExportAllFrameToTempFolder();
                InitMediaPlayer();
            }
        }

        private void FillPatientTagToGridView()
        {
            DataTable table = new DataTable();
            table.Columns.Add("TagName", System.Type.GetType("System.String"));
            table.Columns.Add("TagDes", System.Type.GetType("System.String"));
            table.Columns.Add("TagValue", System.Type.GetType("System.String"));
            var list = DICOMManager.shared.GetPatientTag();
            foreach (var item in list)
            {
                table.Rows.Add(item.TagName, item.TagDescription, item.TagValue);
            }
            dataGridViewPatientTag.DataSource = table;
            dataGridViewPatientTag.Columns[0].Visible = false;
        }

        private void FillAllTagToGridView()
        {
            DataTable table = new DataTable();
            table.Columns.Add("TagName", System.Type.GetType("System.String"));
            table.Columns.Add("TagDes", System.Type.GetType("System.String"));
            table.Columns.Add("TagValue", System.Type.GetType("System.String"));
            var list = DICOMManager.shared.GetAllTag();
            foreach (var item in list)
            {
                table.Rows.Add(item.TagName, item.TagDescription, item.TagValue);
            }
            dataGridViewAllTag.DataSource = table;
            dataGridViewAllTag.Columns[0].Visible = false;
        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {
            imagePanel1.Zoom = trackBar1.Value * 0.1f;
            labelZoom.Text = trackBar1.Value * 10 + "%";
        }

        private void buttonZoomIn_Click(object sender, EventArgs e)
        {
            if (trackBar1.Value > trackBar1.Minimum)
            {
                trackBar1.Value -= 1;
                imagePanel1.Zoom = trackBar1.Value * 0.1f;
                labelZoom.Text = trackBar1.Value * 10 + "%";
            }
        }

        private void buttonZoomOut_Click(object sender, EventArgs e)
        {
            if (trackBar1.Value < trackBar1.Maximum)
            {
                trackBar1.Value += 1;
                imagePanel1.Zoom = trackBar1.Value * 0.1f;
                labelZoom.Text = trackBar1.Value * 10 + "%";
            }
        }
    }
}
