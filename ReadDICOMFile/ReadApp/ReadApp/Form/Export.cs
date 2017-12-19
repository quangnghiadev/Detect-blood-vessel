using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ReadApp.Manager;
using System.Drawing.Imaging;

namespace ReadApp
{
    public partial class Export : Form
    {
        String filePath;
        public Export()
        {
            InitializeComponent();
            cbOptions.SelectedIndex = 1;
            int[] arr = Enumerable.Range(1, DICOMManager.shared.FrameCount).ToArray();
            cbFrame.DataSource = arr;
        }

        public Export(String path)
        {
            InitializeComponent();
            cbOptions.SelectedIndex = 1;
            filePath = path;
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void cbOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbOptions.SelectedIndex == 0)
            {
                cbFrame.Enabled = true;
            } else
            {
                cbFrame.Enabled = false;
            }
        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            SaveFileDialog sfd = new SaveFileDialog();
            sfd.Filter = "png(*.png)| *.png; |Bitmap(*.bmp)| *.bmp; | JPG(*.jpg)| *.jpg; | GIF(*.gif)| *.gif; | TIFF(*.tif)| *.tif";

            if (cbOptions.SelectedIndex == 0)
            {
                
                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    var frame = cbFrame.SelectedIndex + 1;
                    var fullPath = sfd.FileName;
                    System.Threading.Thread t = new System.Threading.Thread(() => {
                        DICOMManager.shared.ExportFrame(frame, getFormat(fullPath), fullPath);
                        this.Invoke(new ShowSuccessDialog(ShowDialog));
                    });
                    t.Start();
                }
            } else if(cbOptions.SelectedIndex == 1)
            {
                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    var fullPath = sfd.FileName;
                    var fileType = fullPath.Split('.').Last();
                    var folderPath = fullPath.Replace("."+fileType , "\\");
                    if(fileType.CompareTo("gif") ==0)
                    {
                        System.Threading.Thread t = new System.Threading.Thread(() => {
                            DICOMManager.shared.ExportGifFile(fullPath);
                            this.Invoke(new ShowSuccessDialog(ShowDialog));
                        });
                        t.Start();
                    }
                    else
                    {
                        System.Threading.Thread t = new System.Threading.Thread(() => {
                            DICOMManager.shared.ExportAllFrame(getFormat(fullPath), folderPath);
                            this.Invoke(new ShowSuccessDialog(ShowDialog));
                        });
                        t.Start();
                    }
                    
                }
            }
        }

        public delegate void ShowSuccessDialog();

        private void ShowDialog()
        {
            MessageBox.Show("Export success!");
        }
        
        private ImageFormat getFormat(String filePath)
        {
            var stringType = filePath.Split('\\').Last();
            if (stringType.CompareTo("png") == 0)
            {
                return ImageFormat.Png;
            }

            if (stringType.CompareTo("bmp") == 0)
            {
                return ImageFormat.Bmp;
            }

            if (stringType.CompareTo("jpg") == 0)
            {
                return ImageFormat.Jpeg;
            }

            if (stringType.CompareTo("gif") == 0)
            {
                return ImageFormat.Gif;
            }

            if (stringType.CompareTo("tif") == 0)
            {
                return ImageFormat.Tiff;
            }

            return ImageFormat.Jpeg;
        }


    }
}
