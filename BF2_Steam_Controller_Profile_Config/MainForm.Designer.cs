namespace BF2_Steam_Controller_Profile_Config
{
    partial class MainForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.pictureBoxController = new System.Windows.Forms.PictureBox();
            this.text_info = new System.Windows.Forms.RichTextBox();
            this.comboBox_mode = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnLoadProfile = new System.Windows.Forms.Button();
            this.btnSaveProfile = new System.Windows.Forms.Button();
            this.btnAutoFix = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxController)).BeginInit();
            this.SuspendLayout();
            // 
            // pictureBoxController
            // 
            this.pictureBoxController.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pictureBoxController.Image = ((System.Drawing.Image)(resources.GetObject("pictureBoxController.Image")));
            this.pictureBoxController.Location = new System.Drawing.Point(111, 37);
            this.pictureBoxController.Name = "pictureBoxController";
            this.pictureBoxController.Size = new System.Drawing.Size(522, 357);
            this.pictureBoxController.TabIndex = 0;
            this.pictureBoxController.TabStop = false;
            this.pictureBoxController.MouseClick += new System.Windows.Forms.MouseEventHandler(this.pictureBoxController_MouseClick);
            // 
            // text_info
            // 
            this.text_info.Location = new System.Drawing.Point(1, 37);
            this.text_info.Name = "text_info";
            this.text_info.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.text_info.Size = new System.Drawing.Size(104, 357);
            this.text_info.TabIndex = 1;
            this.text_info.Text = "";
            this.text_info.Visible = false;
            // 
            // comboBox_mode
            // 
            this.comboBox_mode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_mode.FormattingEnabled = true;
            this.comboBox_mode.Items.AddRange(new object[] {
            "Ifantry",
            "Vehicle",
            "Starfighter",
            "Jedi",
            "Turret"});
            this.comboBox_mode.Location = new System.Drawing.Point(319, 10);
            this.comboBox_mode.Name = "comboBox_mode";
            this.comboBox_mode.Size = new System.Drawing.Size(216, 21);
            this.comboBox_mode.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(209, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(81, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Controller Mode";
            // 
            // btnLoadProfile
            // 
            this.btnLoadProfile.Location = new System.Drawing.Point(111, 407);
            this.btnLoadProfile.Name = "btnLoadProfile";
            this.btnLoadProfile.Size = new System.Drawing.Size(183, 33);
            this.btnLoadProfile.TabIndex = 4;
            this.btnLoadProfile.Text = "&Load Profile";
            this.btnLoadProfile.UseVisualStyleBackColor = true;
            this.btnLoadProfile.Click += new System.EventHandler(this.btnLoadProfile_Click);
            // 
            // btnSaveProfile
            // 
            this.btnSaveProfile.Enabled = false;
            this.btnSaveProfile.Location = new System.Drawing.Point(450, 407);
            this.btnSaveProfile.Name = "btnSaveProfile";
            this.btnSaveProfile.Size = new System.Drawing.Size(183, 33);
            this.btnSaveProfile.TabIndex = 5;
            this.btnSaveProfile.Text = "&Save Profile";
            this.btnSaveProfile.UseVisualStyleBackColor = true;
            this.btnSaveProfile.Click += new System.EventHandler(this.btnSaveProfile_Click);
            // 
            // btnAutoFix
            // 
            this.btnAutoFix.Enabled = false;
            this.btnAutoFix.Location = new System.Drawing.Point(1, 3);
            this.btnAutoFix.Name = "btnAutoFix";
            this.btnAutoFix.Size = new System.Drawing.Size(183, 23);
            this.btnAutoFix.TabIndex = 6;
            this.btnAutoFix.Text = "Autofix roll/transform";
            this.btnAutoFix.UseVisualStyleBackColor = true;
            this.btnAutoFix.Click += new System.EventHandler(this.btnAutoFix_Click);
            // 
            // MainForm
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.ClientSize = new System.Drawing.Size(737, 473);
            this.Controls.Add(this.btnAutoFix);
            this.Controls.Add(this.btnSaveProfile);
            this.Controls.Add(this.btnLoadProfile);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.comboBox_mode);
            this.Controls.Add(this.text_info);
            this.Controls.Add(this.pictureBoxController);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "MainForm";
            this.Text = "BF2 Controller Profile Tool";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxController)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox pictureBoxController;
        private System.Windows.Forms.RichTextBox text_info;
        private System.Windows.Forms.ComboBox comboBox_mode;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnLoadProfile;
        private System.Windows.Forms.Button btnSaveProfile;
        private System.Windows.Forms.Button btnAutoFix;
    }
}

