using System.Windows.Forms;
using ReadApp.Manager;
using System.Data;
using System;
using System.IO;
using System.Windows.Forms;
using System.Linq;
using System.Drawing;
using System.Drawing.Imaging;

namespace ReadApp
{
    public partial class MainForm : Form
    {
<<<<<<< HEAD
        static Timer myTimer = new System.Windows.Forms.Timer();
        int i = 1;
=======
        static System.Windows.Forms.Timer myTimer = new System.Windows.Forms.Timer();
        int currentFrame = 1;
>>>>>>> 7201b18e504e35c05abbf5b61e96a099ff41b83c
        String dataPath = Application.StartupPath + "\\data\\";
        int currentIndex = 86698558;
        int currentCount;
        public MainForm()
        {
            InitializeComponent();
            //currentCount = (from file in Directory.EnumerateFiles(getFullPath(), "*.jpg", SearchOption.AllDirectories)
            //                select file).Count();
            //myTimer.Tick += new EventHandler(TimerEventProcessor);

            //// Sets the timer interval to 5 seconds.
            //myTimer.Interval = 80;
            //myTimer.Start();
        }

        private void TimerEventProcessor(Object myObject,
                                              EventArgs myEventArgs)
        {

            myTimer.Stop();

            // Displays a message box asking whether to continue running the timer.
            myTimer.Enabled = true;
            pictureBox1.Image = Image.FromFile(getFullPath() + currentFrame % currentCount + ".jpg");
            tbFrame.Text = (currentFrame % currentCount).ToString();
            currentFrame += 1;
        }

        private string getFullPath()
        {
            return dataPath + currentIndex + "\\";
        }

        private void btnPlay_Click(object sender, EventArgs e)
        {
            myTimer.Enabled = !myTimer.Enabled;
            btnPlay.Image = !myTimer.Enabled ? Properties.Resources.play_button : Properties.Resources.pause;
        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            currentFrame = 0;
            pause();
            pictureBox1.Image = Image.FromFile(getFullPath() + currentFrame % currentCount + ".jpg");
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            currentFrame += 1;
            pause();
            pictureBox1.Image = Image.FromFile(getFullPath() + currentFrame % currentCount + ".jpg");
        }

        private void btnPrevious_Click(object sender, EventArgs e)
        {
            currentFrame -= 1;
            pause();
            pictureBox1.Image = Image.FromFile(getFullPath() + currentFrame % currentCount + ".jpg");
        }

        private void pause()
        {
            myTimer.Enabled = false;
            btnPlay.Image = Properties.Resources.play_button;
            tbFrame.Text = (currentFrame % currentCount).ToString();
        }

        private void MainForm_Load(object sender, System.EventArgs e)
        {

        }

        private void buttonOpen_Click(object sender, System.EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                DICOMManager.shared.Read(openFileDialog1.FileName, openFileDialog1.SafeFileName);
                FillPatientInformationGridView();
                DICOMManager.shared.ExportAllFrameToTempFolder();
            }
        }

        private void FillPatientInformationGridView()
        {
            DataTable table = new DataTable();
            table.Columns.Add("TagName", System.Type.GetType("System.String"));
            table.Columns.Add("TagDes", System.Type.GetType("System.String"));
            table.Columns.Add("TagValue", System.Type.GetType("System.String"));
            var list = DICOMManager.shared.GetPatientInformation();
            foreach (var item in list)
            {
                table.Rows.Add(item.TagName, item.TagDescription, item.TagValue);
            }
            dataGridViewPatientInfo.DataSource = table;
            dataGridViewPatientInfo.Columns[0].Visible = false;
        }

        private void tbFrame_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                currentFrame = Int32.Parse(tbFrame.Text)%currentCount;
                pause();
                pictureBox1.Image = Image.FromFile(getFullPath() + currentFrame % currentCount + ".jpg");
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
    }
}
