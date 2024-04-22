# Muninn

## Overview
`Muninn.ps1` is a powerful PowerShell script designed to encode binary files into Base64 format and decode Base64 strings back into binary files. Named after the Norse mythology raven Muninn, which represents "memory", this tool encapsulates the ability to preserve and recall data through encoding and decoding processes.

## Features
- **Encode Binary to Base64**: Converts any binary file into a Base64 encoded text file, making it easier to transmit binary data over channels that only support text.
- **Decode Base64 to Binary**: Reverses the encoding process, converting Base64 encoded text back into its original binary form.
- **User-friendly Interface**: Utilizes file dialog boxes for easy selection of input and output files.
- **Flexible Output Options**: Offers users the choice to either directly execute the decoded binaries or save them to disk.

## Requirements
- **PowerShell 5.0 or higher**: Ensure that your system is running PowerShell 5.0 or later.
- **Windows Operating System**: Designed specifically for Windows due to the use of Windows Forms for file dialog interactions.

## Usage

### Encoding a File
1. Run `Muninn.ps1`.
2. Choose the option to encode a binary to Base64.
3. Use the file dialog to select the binary file you wish to encode.
4. Choose where to save the encoded Base64 text file.

### Decoding a File
1. Run `Muninn.ps1`.
2. Choose the option to decode Base64 to a binary.
3. Use the file dialog to select the Base64 text file you wish to decode.
4. Decide whether to directly execute the binary or save it:
   - If executing, the script will run the binary and then delete it from memory.
   - If saving, choose the location to save the decoded binary file.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.

## Contributions
Contributions are welcome. Please fork the repository and submit a pull request with your enhancements.

## Support
For support, feature requests, or bug reporting, please open an issue in the project repository on GitHub.

## About
`Muninn.ps1` was developed to provide a reliable and secure method for handling binary data conversions, inspired by the wisdom and memory attributes of Muninn from Norse mythology.

