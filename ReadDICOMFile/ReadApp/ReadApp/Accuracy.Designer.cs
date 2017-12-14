namespace ReadApp
{
    partial class Accuracy
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
            this.labelAccuracy = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.imagePanelResult = new YLScsImage.ImagePanel();
            this.imagePanelGroundTruth = new YLScsImage.ImagePanel();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelAccuracy
            // 
            this.labelAccuracy.AutoSize = true;
            this.labelAccuracy.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelAccuracy.Location = new System.Drawing.Point(577, 9);
            this.labelAccuracy.Name = "labelAccuracy";
            this.labelAccuracy.Size = new System.Drawing.Size(27, 15);
            this.labelAccuracy.TabIndex = 15;
            this.labelAccuracy.Text = "0%";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(504, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(67, 15);
            this.label1.TabIndex = 12;
            this.label1.Text = "Accuracy:";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(842, 39);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(87, 15);
            this.label3.TabIndex = 14;
            this.label3.Text = "Ground truth";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(249, 39);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(48, 15);
            this.label2.TabIndex = 13;
            this.label2.Text = "Result";
            // 
            // splitContainer1
            // 
            this.splitContainer1.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.splitContainer1.Location = new System.Drawing.Point(21, 68);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.imagePanelResult);
            this.splitContainer1.Panel1MinSize = 550;
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.imagePanelGroundTruth);
            this.splitContainer1.Size = new System.Drawing.Size(1098, 551);
            this.splitContainer1.SplitterDistance = 550;
            this.splitContainer1.TabIndex = 16;
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // imagePanelResult
            // 
            this.imagePanelResult.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelResult.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelResult.Image = null;
            this.imagePanelResult.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelResult.Location = new System.Drawing.Point(0, 0);
            this.imagePanelResult.Name = "imagePanelResult";
            this.imagePanelResult.Size = new System.Drawing.Size(550, 551);
            this.imagePanelResult.TabIndex = 8;
            this.imagePanelResult.Zoom = 1F;
            // 
            // imagePanelGroundTruth
            // 
            this.imagePanelGroundTruth.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelGroundTruth.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelGroundTruth.Image = null;
            this.imagePanelGroundTruth.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelGroundTruth.Location = new System.Drawing.Point(0, 0);
            this.imagePanelGroundTruth.Name = "imagePanelGroundTruth";
            this.imagePanelGroundTruth.Size = new System.Drawing.Size(544, 551);
            this.imagePanelGroundTruth.TabIndex = 9;
            this.imagePanelGroundTruth.Zoom = 1F;
            this.imagePanelGroundTruth.Click += new System.EventHandler(this.imagePanelGroundTruth_Click);
            // 
            // Accuracy
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1145, 631);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.labelAccuracy);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Accuracy";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Accuracy";
            this.Load += new System.EventHandler(this.Accuracy_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label labelAccuracy;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private YLScsImage.ImagePanel imagePanelGroundTruth;
        private YLScsImage.ImagePanel imagePanelResult;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
    }
}