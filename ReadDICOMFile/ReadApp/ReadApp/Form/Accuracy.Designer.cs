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
            this.imagePanelResult = new YLScsImage.ImagePanel();
            this.imagePanelGroundTruth = new YLScsImage.ImagePanel();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.buttonOpenGroundTruth = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox3.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelAccuracy
            // 
            this.labelAccuracy.AutoSize = true;
            this.labelAccuracy.Location = new System.Drawing.Point(87, 16);
            this.labelAccuracy.Name = "labelAccuracy";
            this.labelAccuracy.Size = new System.Drawing.Size(21, 13);
            this.labelAccuracy.TabIndex = 15;
            this.labelAccuracy.Text = "0%";
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
            this.imagePanelResult.TabIndex = 8;
            this.imagePanelResult.Zoom = 1F;
            // 
            // imagePanelGroundTruth
            // 
            this.imagePanelGroundTruth.CanvasSize = new System.Drawing.Size(60, 40);
            this.imagePanelGroundTruth.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imagePanelGroundTruth.Image = null;
            this.imagePanelGroundTruth.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            this.imagePanelGroundTruth.Location = new System.Drawing.Point(3, 16);
            this.imagePanelGroundTruth.Name = "imagePanelGroundTruth";
            this.imagePanelGroundTruth.Size = new System.Drawing.Size(529, 516);
            this.imagePanelGroundTruth.TabIndex = 9;
            this.imagePanelGroundTruth.Zoom = 1F;
            this.imagePanelGroundTruth.Click += new System.EventHandler(this.imagePanelGroundTruth_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(6, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Accuracy Ratio";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.labelAccuracy);
            this.groupBox3.Location = new System.Drawing.Point(482, 553);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(129, 42);
            this.groupBox3.TabIndex = 19;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Information";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.buttonOpenGroundTruth);
            this.groupBox2.Controls.Add(this.imagePanelGroundTruth);
            this.groupBox2.Location = new System.Drawing.Point(556, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(535, 535);
            this.groupBox2.TabIndex = 18;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Ground Truth";
            // 
            // buttonOpenGroundTruth
            // 
            this.buttonOpenGroundTruth.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonOpenGroundTruth.Location = new System.Drawing.Point(202, 247);
            this.buttonOpenGroundTruth.Name = "buttonOpenGroundTruth";
            this.buttonOpenGroundTruth.Size = new System.Drawing.Size(154, 23);
            this.buttonOpenGroundTruth.TabIndex = 10;
            this.buttonOpenGroundTruth.Text = "Open Ground Truth ";
            this.buttonOpenGroundTruth.UseVisualStyleBackColor = true;
            this.buttonOpenGroundTruth.Click += new System.EventHandler(this.buttonOpenGroundTruth_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.imagePanelResult);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(535, 535);
            this.groupBox1.TabIndex = 17;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Result";
            // 
            // Accuracy
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1105, 602);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Accuracy";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Accuracy";
            this.Load += new System.EventHandler(this.Accuracy_Load);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Label labelAccuracy;
        private YLScsImage.ImagePanel imagePanelGroundTruth;
        private YLScsImage.ImagePanel imagePanelResult;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button buttonOpenGroundTruth;
    }
}