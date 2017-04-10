#KAFHASH : A Tool To Hash Files and Compare it with the Original File's HASH
#Created By Karem Ali 
#It 's Open Source For Every One : Written in PowerShell V2 To be Compatiable With Win 7 and later
#it's a Gift to my Friend Sherif Fathy 

#Hide The PowerShell Window , Take 1 Seconed to do that 
#Thank To StakeOverFlow -AndyLowry 
#It must be at the top of your Code 
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)


#The Begin of Our GUi 
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") #Load The Object of Forms so you can Build GUI Objects Like Button , Check Box , Radio Box , Etc..
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") # Load The Object of Drawing  So you Can Load Images , Change Fonts , Change Color , Etc...


#Creat The Main Form
$Main_Form = New-Object System.Windows.Forms.Form  # First We Creat The Main Form Which Will Contain The Other Objects
$Main_Form.Width = 500   
$Main_Form.Height = 500
$ICON = New-Object System.Drawing.Icon ("C:\Users\Karem\Desktop\New folder\BAD\Kariem.ico") #Creat The ICON Using Drawing.ICon Then Pass The path 
$Main_Form.Text = "KAFHASH"  #The Name Of Your Programe , It will be Shown in The Title Bar and Centered , You Can't Change it's Properties 
$Main_Form.Icon = $ICON
$img =[system.drawing.image]::FromFile("C:\Users\Karem\Desktop\landing4.jpg") #Get The Image Which Will Be The Background oF the Form
#$Main_Form.BackgroundImage = $img  #Set The BackgroundImage
$Main_Form.BackgroundImageLayout = "Center" #Center it if the Size of it is Smaller Than The Form , You Can't Change The Size of Image using .width or .height  So Choose a Proper Image 
$font = New-Object System.Drawing.Font ([System.Drawing.FontFamily]::GenericSerif , 10 , [System.Drawing.FontStyle]::Bold )  #This Will Effect The Text on objects in The Form But Will Not Effect The name oF the Programme in The Title Bar
$Main_Form.font = $font  
$Main_Form.AutoScroll = $false  #To Prevent Scrolling

#Creat Tab Control 
$tap_con = New-Object System.Windows.Forms.TabControl  #We Creat a Tap Control , It likes The Main Form It will Contain The Tap Pages We Will Creat 
$tap_con.Text = "karem"
$tap_con.DataBindings.DefaultDataSourceUpdateMode = 0
$tap_con.Width = 500
$tap_con.Height = 500
$tap_con.top = 0
$tap_con.left = 0
$Main_Form.Controls.Add($tap_con)  # We Add it To The Main Form 

#Creat Hash Calc Tab Page
$Hash_calc = New-Object System.Windows.Forms.TabPage
$Hash_calc.DataBindings.DefaultDataSourceUpdateMode = 0
$Hash_calc.Text = "Hash Calculator”
#$Hash_calc.BackgroundImage = $img
$tap_con.Controls.Add($Hash_calc)  # We Add It to The Tab Control

#Creat Hash Comparsion Tab Page
$Comp_hash = New-Object System.Windows.Forms.TabPage
$Comp_hash.DataBindings.DefaultDataSourceUpdateMode = 0
$Comp_hash.Text = "Hash Comparsion"
$Comp_hash.BackgroundImage = $img
$tap_con.Controls.Add($Comp_hash)   # We Add it to The Tap Control 

#Creat a button
$Browse_button = New-Object System.Windows.Forms.Button  #The Same Way We Created The Form But instead of the .Form it iss .Button , The Same Way With All Objects in System.Windows.Forms
$Browse_button.Text = "Browse" # The Text on The Button
$Browse_button.Width =60
$Browse_button.Height = 20 
$Browse_button.top = 400   # The Position of The Button
$Browse_button.left = 400
$Hash_calc.Controls.Add($Browse_button)   # You Have To Add it to The  Form , it 's Not Added By Default , You Can use this Option to Display an Object after a Certain Object or After a time usin Cmdlt start-sleep -seconds 2  , We Add It here To The TabPage Because we want it to appear in The Tab Page


$Browse_button.Add_Click({   #When you Click This Button Those events Will Occure     
$Dialog.ShowDialog()   # Show The Dialog Which we Will Create in the Next Lines 
$text_box.Text = $Dialog.FileName  # Assign a Value to a Var  
hash_md5    # Call Some Functions
hash_sha1
hash_sha2
})

#Creat the Dialog
$Dialog = New-Object System.Windows.Forms.OpenFileDialog  # The Dialog to browse The Computer for a File 
$Dialog.Filter = "ALL Files (*.*) | *.*|Powershell (*.ps1)| *.ps1|Photoshop (*.PSD) | *.PSD"    # Creat a Filter So you can let the Dialog Show only a Specific Extensions , We Made 3 Types of extensions included All files , you can select any of them from the GUI
 # important if show jelp is not set to true the display of the dialog may fail. The dialog is displayed in the ISE 
 # but when running from commandline it neve pops up
 $Dialog.ShowHelp = $true
 #$Dialog.InitialDirectory = "C:\users\$env:username\Desktop"  # The Initial Directory of The Dialog , if it 's not assigned , The Default is The Path you are in 
 $Dialog.Multiselect = $false  # This is The Default if You Set it to True , The user Can Select Multiple Items
 


#Creat The text area
$text_box = New-Object System.Windows.Forms.TextBox  # The Text box Whicah Will Hold The path of Selected Item 
$text_box.top = 400
$text_box.left = 100
$text_box.Width = 250
$text_box.Height = 20
$Hash_calc.Controls.Add($text_box)


#Creat CheckBox SHA1
$check_box_sha1 = New-Object System.Windows.Forms.CheckBox  
$check_box_sha1.Text = "SHA-1"
$check_box_sha1.top = 50
$check_box_sha1.Left = 135
$check_box_sha1.Width = 90
$check_box_sha1.Padding = 4   # Set a Padding Which is The Distance Between The text and The Border 
$check_box_sha1.BackColor = [System.Drawing.Color]::FromArgb(240,140,100,100)
$Hash_calc.Controls.Add($check_box_sha1)

#Creat CheckBox SHA2
$check_box_sha2 = New-Object System.Windows.Forms.CheckBox
$check_box_sha2.Text = "SHA-2"
$check_box_sha2.top = 50
$check_box_sha2.Left = 235
$check_box_sha2.Width = 90
$check_box_sha2.Padding = 4
$check_box_sha2.BackColor = [System.Drawing.Color]::FromArgb(240,140,100,100)
$Hash_calc.Controls.Add($check_box_sha2)

#Creat CheckBox MD5
$check_box_md5 = New-Object System.Windows.Forms.CheckBox
$check_box_md5.Text = "MD-5"
$check_box_md5.top = 50
$check_box_md5.Left = 30
$check_box_md5.Width = 90
$check_box_md5.Padding =  4 
$check_box_md5.BackColor = [System.Drawing.Color]::FromArgb(205,140,100,100)   # Set aBackground Color to The CheckBox 
$Hash_calc.Controls.Add($check_box_md5)


#Creat MD5 Label
$Md5_lable = New-Object System.Windows.Forms.Label
$Md5_lable.Text = "MD-5: "
$Md5_lable.top = 100
$Md5_lable.Left = 25
$Md5_lable.Width = 60
$Md5_lable.Padding = 4
$Md5_lable.BorderStyle ="none"
$Md5_lable.BackColor = [System.Drawing.Color]::FromArgb(205,140,100,100)
$Hash_calc.Controls.Add($Md5_lable)


#Creat Text Box For MD-5 Result
$Text_area_hash_md5 = New-Object System.Windows.Forms.TextBox
$Text_area_hash_md5.Width = 390
$Text_area_hash_md5.Height = 200
$Text_area_hash_md5.Left = 85
$Text_area_hash_md5.top = 100
$Hash_calc.Controls.Add($Text_area_hash_md5)


#Creat SHA-1 Label
$sha1_lable = New-Object System.Windows.Forms.Label
$sha1_lable.Text = "SHA-1: "
$sha1_lable.top = 150
$sha1_lable.Left = 25
$sha1_lable.Width = 60
$sha1_lable.Padding = 4
$sha1_lable.BorderStyle ="none"
$sha1_lable.BackColor = [System.Drawing.Color]::FromArgb(205,140,100,100)
$Hash_calc.Controls.Add($sha1_lable)


#Creat Text Box For SHA-1 Result
$Text_area_hash_sha1 = New-Object System.Windows.Forms.TextBox
$Text_area_hash_sha1.Width = 390
$Text_area_hash_sha1.Height = 200
$Text_area_hash_sha1.Left = 85
$Text_area_hash_sha1.top = 150
$Hash_calc.Controls.Add($Text_area_hash_sha1)


#Creat SHA-2 Label
$sha2_lable = New-Object System.Windows.Forms.Label
$sha2_lable.Text = "SHA-2: "
$sha2_lable.top = 200
$sha2_lable.Left = 25
$sha2_lable.Width = 60
$sha2_lable.Padding = 4
$sha2_lable.BorderStyle ="none"
$sha2_lable.BackColor = [System.Drawing.Color]::FromArgb(240,140,100,100)
$Hash_calc.Controls.Add($sha2_lable)


#Creat Text Box For SHA-2 Result
$Text_area_hash_sha2 = New-Object System.Windows.Forms.TextBox
$Text_area_hash_sha2.Width = 390
$Text_area_hash_sha2.Height = 200
$Text_area_hash_sha2.Left = 85
$Text_area_hash_sha2.top = 200
$Text_area_hash_sha2.AutoSize = $true
$Hash_calc.Controls.Add($Text_area_hash_sha2)




$MD5 = New-Object System.Security.Cryptography.MD5CryptoServiceProvider    #We Add The Object OF The Hashes So We can use it in this Program
$SHA1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
$SHA2 = New-Object System.Security.Cryptography.SHA256CryptoServiceProvider

function hash_md5() 
{

        if ( $check_box_md5.Checked -eq $true)  # We Check if the User Checked The MD5 Check Box
                {
                      $MD5_File = [System.IO.File]::ReadAllBytes($text_box.Text)  # We Read The Data of The File in Bytes Encoding So We can Pass it to the Hash Function 
                      $Text_area_hash_md5.Text = [System.BitConverter]::ToString($MD5.ComputeHash($MD5_File)) -replace "-",""  # We Generate The Hash Then We Change it into String so it could Be readable we Replace The - to none cause .net Hash library insert a - between evenry to Hexdigits Then we assign The Value of to The Text area Corsponding to its Hash 
                }
}
function hash_sha1() 
{

        if ( $check_box_sha1.Checked -eq $true)
                {
                      $sha1_File = [System.IO.File]::ReadAllBytes($text_box.Text)
                      $Text_area_hash_sha1.Text = [System.BitConverter]::ToString($SHA1.ComputeHash($sha1_File)) -replace "-",""
                }
}


function hash_sha2() 
{

        if ( $check_box_sha2.Checked -eq $true)
                {
                      $sha2_File = [System.IO.File]::ReadAllBytes($text_box.Text)
                      $Text_area_hash_sha2.Text =[System.BitConverter]::ToString($SHA2.ComputeHash($sha2_File)) -replace "-",""
                }
               
}


#اهداء الى صديقى شريف فتحى 
$Sherif = New-Object System.Windows.Forms.Label
$Sherif.text = " اهداء الى صديقى/ شريف فتحى "
$Sherif.top = 10
$Sherif.left = 180
$Sherif.Width = 200
$Hash_calc.Controls.Add($Sherif)
$Main_Form.ShowInTaskbar = $true  # it is true By Default , it it's False The Program will not be Shown in The TaskBar
$Main_Form.ShowDialog()   # it is Hidden By Default ,You Have to Show The main Form Which Contain All other Items so The uSer Can interact with it 



