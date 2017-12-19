namespace ReadApp
{
    partial class Result
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.labelFrameNumber = new System.Windows.Forms.Label();
            this.buttonAccurary = new System.Windows.Forms.Button();
            this.labelTime = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.imagePanelSource = new YLScsImage.ImagePanel();
            this.imagePanelResult = new YLScsImage.ImagePanel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.label2 = new System.Windows.Forms.Label();
            this.comboBoxFrameNumber = new System.Windows.Forms.ComboBox();
            this.buttonForceDetect = new System.Windows.Forms.Button();
            this.buttonSave = new System.Windows.Forms.Button();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(6, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(77, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Frame number:";
            // 
            // labelFrameNumber
            // 
            this.labelFrameNumber.AutoSize = true;
            this.labelFrameNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelFrameNumber.Location = new System.Drawing.Point(100, 16);
            this.labelFrameNumber.Name = "labelFrameNumber";
            this.labelFrameNumber.Size = new System.Drawing.Size(13, 13);
            this.labelFrameNumber.TabIndex = 5;
            this.labelFrameNumber.Text = "1";
            // 
            // buttonAccurary
            // 
            this.buttonAccurary.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.buttonAccurary.Location = new System.Drawing.Point(9, 78);
            this.buttonAccurary.Name = "buttonAccurary";
            this.buttonAccurary.Size = new System.Drawing.Size(159, 23);
            this.buttonAccurary.TabIndex = 11;
            this.buttonAccurary.Text = "Calculate Accuracy Ratio";
            this.buttonAccurary.UseVisualStyleBackColor = true;
            this.buttonAccurary.Click += new System.EventHandler(this.buttonAccurary_Click);
            // 
            // labelTime
            // 
            this.labelTime.AutoSize = true;
            this.labelTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTime.Location = new System.Drawing.Point(100, 29);
            this.labelTime.Name = "labelTime";
            this.labelTime.Size = new System.Drawing.Size(13, 13);
            this.labelTime.TabIndex = 13;
            this.labelTime.Text = "1";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(6, 29);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(88, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "Processing Time:";
            // 
            // imagePanelSource
            // 
            this.imagePanelSource.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelSource.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelSource.Image = null;
            this.imagePanelSource.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelSource.Location = new System.Drawing.Point(3, 16);
            this.imagePanelSource.Name = "imagePanelSource";
            this.imagePanelSource.Size = new System.Drawing.Size(529, 516);
            this.imagePanelSource.TabIndex = 8;
            this.imagePanelSource.Zoom = 1F;
            // 
            // imagePanelResult
            // 
            this.imagePanelResult.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelResult.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelResult.Image = null;
            this.imagePanelResult.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelResult.Location = new System.Drawing.Point(3, 16);
            this.imagePanelResult.Name = "imagePanelResult";
            this.imagePanelResult.Size = new System.Drawing.Size(529, 516);
            this.imagePanelResult.TabIndex = 9;
            this.imagePanelResult.Zoom = 1F;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.imagePanelSource);
            this.groupBox1.Location = new System.Drawing.Point(12, 39);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(535, 535);
            this.groupBox1.TabIndex = 14;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Source";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.imagePanelResult);
            this.groupBox2.Location = new System.Drawing.Point(556, 39);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(535, 535);
            this.groupBox2.TabIndex = 15;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Result";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.buttonSave);
            this.groupBox3.Controls.Add(this.buttonForceDetect);
            this.groupBox3.Controls.Add(this.label5);
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.labelFrameNumber);
            this.groupBox3.Controls.Add(this.buttonAccurary);
            this.groupBox3.Controls.Add(this.labelTime);
            this.groupBox3.Location = new System.Drawing.Point(458, 580);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(178, 109);
            this.groupBox3.TabIndex = 16;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Information";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(507, 15);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(39, 13);
            this.label2.TabIndex = 17;
            this.label2.Text = "Frame:";
            // 
            // comboBoxFrameNumber
            // 
            this.comboBoxFrameNumber.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBoxFrameNumber.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.comboBoxFrameNumber.FormattingEnabled = true;
            this.comboBoxFrameNumber.Location = new System.Drawing.Point(546, 12);
            this.comboBoxFrameNumber.Name = "comboBoxFrameNumber";
            this.comboBoxFrameNumber.Size = new System.Drawing.Size(47, 21);
            this.comboBoxFrameNumber.TabIndex = 18;
            this.comboBoxFrameNumber.SelectedIndexChanged += new System.EventHandler(this.comboBoxFrameNumber_SelectedIndexChanged);
            // 
            // buttonForceDetect
            // 
            this.buttonForceDetect.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.buttonForceDetect.Location = new System.Drawing.Point(9, 49);
            this.buttonForceDetect.Name = "buttonForceDetect";
            this.buttonForceDetect.Size = new System.Drawing.Size(75, 23);
            this.buttonForceDetect.TabIndex = 20;
            this.buttonForceDetect.Text = "Detect";
            this.buttonForceDetect.UseVisualStyleBackColor = true;
            this.buttonForceDetect.Click += new System.EventHandler(this.buttonForceDetect_Click);
            // 
            // buttonSave
            // 
            this.buttonSave.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.buttonSave.Location = new System.Drawing.Point(93, 49);
            this.buttonSave.Name = "buttonSave";
            this.buttonSave.Size = new System.Drawing.Size(75, 23);
            this.buttonSave.TabIndex = 21;
            this.buttonSave.Text = "Save Result";
            this.buttonSave.UseVisualStyleBackColor = true;
            this.buttonSave.Click += new System.EventHandler(this.buttonSave_Click);
            // 
            // Result
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1103, 696);
            this.Controls.Add(this.comboBoxFrameNumber);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Result";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Detect Vessel";
            this.Load += new System.EventHandler(this.Result_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label labelFrameNumber;
        private YLScsImage.ImagePanel imagePanelSource;
        private YLScsImage.ImagePanel imagePanelResult;
        private System.Windows.Forms.Button buttonAccurary;
        private System.Windows.Forms.Label labelTime;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox comboBoxFrameNumber;
        private System.Windows.Forms.Button buttonSave;
        private System.Windows.Forms.Button buttonForceDetect;
        private System.Windows.Forms.SaveFileDialog saveFileDialog1;
    }
}