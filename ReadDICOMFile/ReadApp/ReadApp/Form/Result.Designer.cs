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
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.labelFrameNumber = new System.Windows.Forms.Label();
            this.imagePanelResult = new YLScsImage.ImagePanel();
            this.imagePanelSource = new YLScsImage.ImagePanel();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.buttonAccurary = new System.Windows.Forms.Button();
            this.labelTime = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(464, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Frame number:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(247, 39);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 15);
            this.label2.TabIndex = 1;
            this.label2.Text = "Source";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(859, 39);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(48, 15);
            this.label3.TabIndex = 2;
            this.label3.Text = "Result";
            // 
            // labelFrameNumber
            // 
            this.labelFrameNumber.AutoSize = true;
            this.labelFrameNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelFrameNumber.Location = new System.Drawing.Point(575, 9);
            this.labelFrameNumber.Name = "labelFrameNumber";
            this.labelFrameNumber.Size = new System.Drawing.Size(15, 15);
            this.labelFrameNumber.TabIndex = 5;
            this.labelFrameNumber.Text = "1";
            // 
            // imagePanelResult
            // 
            this.imagePanelResult.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelResult.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelResult.Image = null;
            this.imagePanelResult.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelResult.Location = new System.Drawing.Point(0, 0);
            this.imagePanelResult.Name = "imagePanelResult";
            this.imagePanelResult.Size = new System.Drawing.Size(544, 551);
            this.imagePanelResult.TabIndex = 9;
            this.imagePanelResult.Zoom = 1F;
            // 
            // imagePanelSource
            // 
            this.imagePanelSource.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelSource.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelSource.Image = null;
            this.imagePanelSource.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelSource.Location = new System.Drawing.Point(0, 0);
            this.imagePanelSource.Name = "imagePanelSource";
            this.imagePanelSource.Size = new System.Drawing.Size(550, 551);
            this.imagePanelSource.TabIndex = 8;
            this.imagePanelSource.Zoom = 1F;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.splitContainer1.Location = new System.Drawing.Point(0, 68);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.imagePanelSource);
            this.splitContainer1.Panel1MinSize = 550;
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.imagePanelResult);
            this.splitContainer1.Size = new System.Drawing.Size(1098, 551);
            this.splitContainer1.SplitterDistance = 550;
            this.splitContainer1.TabIndex = 10;
            // 
            // buttonAccurary
            // 
            this.buttonAccurary.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.buttonAccurary.Location = new System.Drawing.Point(515, 624);
            this.buttonAccurary.Name = "buttonAccurary";
            this.buttonAccurary.Size = new System.Drawing.Size(75, 23);
            this.buttonAccurary.TabIndex = 11;
            this.buttonAccurary.Text = "Accuracy";
            this.buttonAccurary.UseVisualStyleBackColor = true;
            this.buttonAccurary.Click += new System.EventHandler(this.buttonAccurary_Click);
            // 
            // labelTime
            // 
            this.labelTime.AutoSize = true;
            this.labelTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTime.Location = new System.Drawing.Point(575, 24);
            this.labelTime.Name = "labelTime";
            this.labelTime.Size = new System.Drawing.Size(15, 15);
            this.labelTime.TabIndex = 13;
            this.labelTime.Text = "1";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(526, 24);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(43, 15);
            this.label5.TabIndex = 12;
            this.label5.Text = "Time:";
            // 
            // Result
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1098, 654);
            this.Controls.Add(this.labelTime);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.buttonAccurary);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.labelFrameNumber);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Result";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Detect Vessel";
            this.Load += new System.EventHandler(this.Result_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label labelFrameNumber;
        private YLScsImage.ImagePanel imagePanelSource;
        private YLScsImage.ImagePanel imagePanelResult;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.Button buttonAccurary;
        private System.Windows.Forms.Label labelTime;
        private System.Windows.Forms.Label label5;
    }
}