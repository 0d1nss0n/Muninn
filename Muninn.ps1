# @@@@@@@@@@   @@@  @@@  @@@  @@@  @@@  @@@  @@@  @@@  @@@  
# @@@@@@@@@@@  @@@  @@@  @@@@ @@@  @@@  @@@@ @@@  @@@@ @@@  
# @@! @@! @@!  @@!  @@@  @@!@!@@@  @@!  @@!@!@@@  @@!@!@@@  
# !@! !@! !@!  !@!  @!@  !@!!@!@!  !@!  !@!!@!@!  !@!!@!@!  
# @!! !!@ @!@  @!@  !@!  @!@ !!@!  !!@  @!@ !!@!  @!@ !!@!  
# !@!   ! !@!  !@!  !!!  !@!  !!!  !!!  !@!  !!!  !@!  !!!  
# !!:     !!:  !!:  !!!  !!:  !!!  !!:  !!:  !!!  !!:  !!!  
# :!:     :!:  :!:  !:!  :!:  !:!  :!:  :!:  !:!  :!:  !:!  
# :::     ::   ::::: ::   ::   ::   ::   ::   ::   ::   ::  
#  :      :     : :  :   ::    :   :    ::    :   ::    :  
#
# There are two main functions to this script. 
#
# This first will take an .exe and converts it into a Base64 string. 
# It will then save the Base64 string into a text document. 
#
# The second will take a .txt file that contains the encoded Base64 
# string and will proceed to ask the user if they would like to run
# the program from memory without saving the .exe to the device 
# OR
# if the user chooses to not run from memory then the script will 
# ask the user to name the .exe and will save the decoded.exe to the 
# device. 
#
# Created by: 0d1nss0n
# Version 1.0
#

Add-Type -AssemblyName System.Windows.Forms

Write-Host "Choose Operation:"
Write-Host "1: Encode a binary to Base64"
Write-Host "2: Decode Base64 to a binary"
Write-Host "3: Cancel"
$operation = Read-Host "Enter your choice (1, 2, or 3)"

switch ($operation) {
    '1' {  # Encoding binary to Base64
        $openDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openDialog.Filter = "Executable files (*.exe)|*.exe|All files (*.*)|*.*"
        $openDialog.Title = "Select a Binary File"

        if ($openDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $InputFilePath = $openDialog.FileName
            $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
            $saveDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
            $saveDialog.Title = "Save the Base64 Output"
            $saveDialog.FileName = "EncodedOutput.txt"

            if ($saveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
                $OutputFilePath = $saveDialog.FileName
                try {
                    $FileBytes = [System.IO.File]::ReadAllBytes($InputFilePath)
                    $Base64EncodedString = [Convert]::ToBase64String($FileBytes)
                    [System.IO.File]::WriteAllText($OutputFilePath, $Base64EncodedString)
                    Write-Host "Base64 encoded data has been saved to: $OutputFilePath"
                } catch {
                    Write-Host "An error occurred: $_"
                }
            } else {
                Write-Host "No output file was selected."
            }
        } else {
            Write-Host "No input file was selected."
        }
    }
    '2' {   # Decoding Base64 to binary
        $openDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
        $openDialog.Title = "Select a Base64 Encoded File"

        if ($openDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $InputFilePath = $openDialog.FileName

            try {
                $Base64EncodedString = [System.IO.File]::ReadAllText($InputFilePath)
                $CompressedBytes = [Convert]::FromBase64String($Base64EncodedString)

                Write-Host "Do you want to run the executable directly from memory or save it?"
                Write-Host "1: Run directly from memory"
                Write-Host "2: Save the executable"
                Write-Host "3: Cancel"
                $choice = Read-Host "Enter your choice (1, 2, or 3)"

                switch ($choice) {
                    '1' { # Run directly from memory
                        $ExecutablePath = [System.IO.Path]::GetTempFileName() + ".exe"
                        [System.IO.File]::WriteAllBytes($ExecutablePath, $CompressedBytes)
                        Start-Process $ExecutablePath
                        [System.IO.File]::Delete($ExecutablePath)
                        Write-Host "Executable has been run and removed from memory."
                    }
                    '2' { # Save the executable
                        $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
                        $saveDialog.Filter = "Executable files (*.exe)|*.exe|All files (*.*)|*.*"
                        $saveDialog.Title = "Save the Decoded Executable"
                        $saveDialog.FileName = "DecodedExecutable.exe"
                        if ($saveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
                            $OutputFilePath = $saveDialog.FileName
                            [System.IO.File]::WriteAllBytes($OutputFilePath, $CompressedBytes)
                            Write-Host "Executable has been decoded and saved to: $OutputFilePath"
                        } else {
                            Write-Host "No output file was selected."
                        }
                    }
                    '3' {
                        Write-Host "Operation cancelled by the user."
                    }
                }
            } catch {
                Write-Host "An error occurred: $_"
            }
        } else {
            Write-Host "No input file was selected."
        }
    }
    '3' {
        Write-Host "Operation cancelled by the user."
    }
}
