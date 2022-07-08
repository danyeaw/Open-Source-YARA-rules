// Animal Farm yara rules
// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2015, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

rule ramFS
{
    meta:
        Author      = "Joan Calvet"
        Date        = "2015/07/14"
        Description = "RamFS -- custom file system used by Animal Farm malware"
        Reference   = "http://www.welivesecurity.com/2015/06/30/dino-spying-malware-analyzed/"
        Source = "https://github.com/eset/malware-ioc/"
        Contact = "github@eset.com"
        License = "BSD 2-Clause"

    strings:
        $mz = { 4d 5a }

        // Debug strings in RamFS
        $s01 = "Check: Error in File_List"
        $s02 = "Check: Error in FreeFileHeader_List"
        $s03 = "CD-->[%s]"
        $s04 = "!!!EXTRACT ERROR!!!File Does Not Exists-->[%s]"
        // RamFS parameters stored in the configuration
        $s05 = "tr4qa589" fullword
        $s06 = "xT0rvwz" fullword

        // RamFS commands
        $c01 = "INSTALL" fullword
        $c02 = "EXTRACT" fullword
        $c03 = "DELETE" fullword
        $c04 = "EXEC" fullword
        $c05 = "INJECT" fullword
        $c06 = "SLEEP" fullword
        $c07 = "KILL" fullword
        $c08 = "AUTODEL" fullword
        $c09 = "CD" fullword
        $c10 = "MD" fullword        

    condition:
        ( $mz at 0 ) and
            ((1 of ($s*)) or (all of ($c*)))
}

rule dino
{
    meta:
        Author      = "Joan Calvet"
        Date        = "2015/07/14"
        Description = "Dino backdoor"
        Reference   = "http://www.welivesecurity.com/2015/06/30/dino-spying-malware-analyzed/"
        Source = "https://github.com/eset/malware-ioc/"
        Contact = "github@eset.com"
        License = "BSD 2-Clause"

    strings:
        $ = "PsmIsANiceM0du1eWith0SugarInsideA"
        $ = "destroyPSM"
        $ = "FM_PENDING_DOWN_%X"
        $ = "%s was canceled after %d try (reached MaxTry parameter)"
        $ = "you forgot value name"
        $ = "wakeup successfully scheduled in %d minutes"
        $ = "BD started at %s"
        $ = "decyphering failed on bd"

    condition:
        any of them
}

// Linux/Moose yara rules
// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2015, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
private rule is_elf
{
    strings:
        $header = { 7F 45 4C 46 }

    condition:
        $header at 0
}

rule moose
{
    meta:
        Author      = "Thomas Dupuy"
        Date        = "2015/04/21"
        Description = "Linux/Moose malware"
        Reference   = "http://www.welivesecurity.com/wp-content/uploads/2015/05/Dissecting-LinuxMoose.pdf"
        Source = "https://github.com/eset/malware-ioc/"
        Contact = "github@eset.com"
        License = "BSD 2-Clause"

    strings:
        $s0 = "Status: OK"
        $s1 = "--scrypt"
        $s2 = "stratum+tcp://"
        $s3 = "cmd.so"
        $s4 = "/Challenge"
        $s7 = "processor"
        $s9 = "cpu model"
        $s21 = "password is wrong"
        $s22 = "password:"
        $s23 = "uthentication failed"
        $s24 = "sh"
        $s25 = "ps"
        $s26 = "echo -n -e "
        $s27 = "chmod"
        $s28 = "elan2"
        $s29 = "elan3"
        $s30 = "chmod: not found"
        $s31 = "cat /proc/cpuinfo"
        $s32 = "/proc/%s/cmdline"
        $s33 = "kill %s"

    condition:
        is_elf and all of them
}

// Mumblehard packer yara rule
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2015, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

rule mumblehard_packer
{
    meta:
        description = "Mumblehard i386 assembly code responsible for decrypting Perl code"
        author = "Marc-Etienne M. Leveille"
        date = "2015-04-07"
        reference = "http://www.welivesecurity.com"
        version = "1"

    strings:
        $decrypt = { 31 db  [1-10]  ba ?? 00 00 00  [0-6]  (56 5f |  89 F7)
                     39 d3 75 13 81 fa ?? 00 00 00 75 02 31 d2 81 c2 ?? 00 00
                     00 31 db 43 ac 30 d8 aa 43 e2 e2 }
    condition:
        $decrypt
}

// Operation Potao yara rules
// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2015, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
private rule PotaoDecoy
{
    strings:
        $mz = { 4d 5a }
        $str1 = "eroqw11"
        $str2 = "2sfsdf"
        $str3 = "RtlDecompressBuffer"
        $wiki_str = "spanned more than 100 years and ruined three consecutive" wide

        $old_ver1 = {53 68 65 6C 6C 33 32 2E 64 6C 6C 00 64 61 66 73 72 00 00 00 64 61 66 73 72 00 00 00 64 6F 63 (00 | 78)}
        $old_ver2 = {6F 70 65 6E 00 00 00 00 64 6F 63 00 64 61 66 73 72 00 00 00 53 68 65 6C 6C 33 32 2E 64 6C 6C 00}       
    condition:
        ($mz at 0) and ( (all of ($str*)) or any of ($old_ver*) or $wiki_str )
}
private rule PotaoDll
{
    strings:
        $mz = { 4d 5a }
        
        $dllstr1 = "?AVCncBuffer@@"
        $dllstr2 = "?AVCncRequest@@"
        $dllstr3 = "Petrozavodskaya, 11, 9"
        $dllstr4 = "_Scan@0"
        $dllstr5 = "\x00/sync/document/"
        $dllstr6 = "\\temp.temp"
        
        $dllname1 = "node69MainModule.dll"
        $dllname2 = "node69-main.dll"
        $dllname3 = "node69MainModuleD.dll"
        $dllname4 = "task-diskscanner.dll"
        $dllname5 = "\x00Screen.dll"
        $dllname6 = "Poker2.dll"        
        $dllname7 = "PasswordStealer.dll"
        $dllname8 = "KeyLog2Runner.dll" 
        $dllname9 = "GetAllSystemInfo.dll"          
        $dllname10 = "FilePathStealer.dll"          
    condition:
        ($mz at 0) and (any of ($dllstr*) and any of ($dllname*))
}
private rule PotaoUSB
{
    strings:
        $mz = { 4d 5a }
        
        $binary1 = { 33 C0 8B C8 83 E1 03 BA ?? ?? ?? 00 2B D1 8A 0A 32 88 ?? ?? ?? 00 2A C8 FE C9 88 88 ?? ?? ?? 00 40 3D ?? ?? 00 00 7C DA C3 }
        $binary2 = { 55 8B EC 51 56 C7 45 FC 00 00 00 00 EB 09 8B 45 FC 83 C0 01 89 45 FC 81 7D FC ?? ?? 00 00 7D 3D 8B 4D FC 0F BE 89 ?? ?? ?? 00 8B 45 FC 33 D2 BE 04 00 00 00 F7 F6 B8 03 00 00 00 2B C2 0F BE 90 ?? ?? ?? 00 33 CA 2B 4D FC 83 E9 01 81 E1 FF 00 00 00 8B 45 FC 88 88 ?? ?? ?? 00 EB B1 5E 8B E5 5D C3}
    condition:
        ($mz at 0) and any of ($binary*)
}
private rule PotaoSecondStage
{
    strings:
        $mz = { 4d 5a }
        // hash of CryptBinaryToStringA and CryptStringToBinaryA
        $binary1 = {51 7A BB 85 [10-180] E8 47 D2 A8}
        // old hash of CryptBinaryToStringA and CryptStringToBinaryA
        $binary2 = {5F 21 63 DD [10-30] EC FD 33 02}
        $binary3 = {CA 77 67 57 [10-30] BA 08 20 7A}
        
        $str1 = "?AVCrypt32Import@@"
        $str2 = "%.5llx"
    condition:
        ($mz at 0) and any of ($binary*) and any of ($str*)
}
rule Potao
{
    meta:
        Author      = "Anton Cherepanov"
        Date        = "2015/07/29"
        Description = "Operation Potao"
        Reference   = "http://www.welivesecurity.com/wp-content/uploads/2015/07/Operation-Potao-Express_final_v2.pdf"
        Source = "https://github.com/eset/malware-ioc/"
        Contact = "threatintel@eset.com"
        License = "BSD 2-Clause"
    condition:
        PotaoDecoy or PotaoDll or PotaoUSB or PotaoSecondStage
}

// Operation Windigo yara rules
// For feedback or questions contact us at: windigo@eset.sk
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2014, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
rule onimiki
{
  meta:
    description = "Linux/Onimiki malicious DNS server"
    malware = "Linux/Onimiki"
    operation = "Windigo"
    author = "Olivier Bilodeau <bilodeau@eset.com>"
    created = "2014-02-06"
    reference = "http://www.welivesecurity.com/wp-content/uploads/2014/03/operation_windigo.pdf"
    contact = "windigo@eset.sk"
    source = "https://github.com/eset/malware-ioc/"
    license = "BSD 2-Clause"

  strings:
    // code from offset: 0x46CBCD
    $a1 = {43 0F B6 74 2A 0E 43 0F  B6 0C 2A 8D 7C 3D 00 8D}
    $a2 = {74 35 00 8D 4C 0D 00 89  F8 41 F7 E3 89 F8 29 D0}
    $a3 = {D1 E8 01 C2 89 F0 C1 EA  04 44 8D 0C 92 46 8D 0C}
    $a4 = {8A 41 F7 E3 89 F0 44 29  CF 29 D0 D1 E8 01 C2 89}
    $a5 = {C8 C1 EA 04 44 8D 04 92  46 8D 04 82 41 F7 E3 89}
    $a6 = {C8 44 29 C6 29 D0 D1 E8  01 C2 C1 EA 04 8D 04 92}
    $a7 = {8D 04 82 29 C1 42 0F B6  04 21 42 88 84 14 C0 01}
    $a8 = {00 00 42 0F B6 04 27 43  88 04 32 42 0F B6 04 26}
    $a9 = {42 88 84 14 A0 01 00 00  49 83 C2 01 49 83 FA 07}

  condition:
    all of them
}


// Keydnap packer yara rule
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2016, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//


rule keydnap_backdoor
{
    meta:
        description = "Unpacked OSX/Keydnap backdoor"
        author = "Marc-Etienne M. Leveille"
        date = "2016-07-06"
        reference = "http://www.welivesecurity.com/2016/07/06/new-osxkeydnap-malware-is-hungry-for-credentials"
        version = "1"

    strings:
        $ = "api/osx/get_task"
        $ = "api/osx/cmd_executed"
        $ = "Loader-"
        $ = "u2RLhh+!LGd9p8!ZtuKcN"
        $ = "com.apple.iCloud.sync.daemon"
    condition:
        2 of them
}
rule keydnap_downloader
{
    meta:
        description = "OSX/Keydnap Downloader"
        author = "Marc-Etienne M. Leveille"
        date = "2016-07-06"
        reference = "http://www.welivesecurity.com/2016/07/06/new-osxkeydnap-malware-is-hungry-for-credentials"
        version = "1"

    strings:
        $ = "icloudsyncd"
        $ = "killall Terminal"
        $ = "open %s"
    
    condition:
        2 of them
}

rule keydnap_backdoor_packer
{
    meta:
        description = "OSX/Keydnap packed backdoor"
        author = "Marc-Etienne M. Leveille"
        date = "2016-07-06"
        reference = "http://www.welivesecurity.com/2016/07/06/new-osxkeydnap-malware-is-hungry-for-credentials"
        version = "1"

    strings:
        $upx_string = "This file is packed with the UPX"
        $packer_magic = "ASS7"
        $upx_magic = "UPX!"
        
    condition:
        $upx_string and $packer_magic and not $upx_magic
}


rule kobalos
{
    meta:
        description = "Kobalos malware"
        author = "Marc-Etienne M.Léveillé"
        date = "2020-11-02"
        reference = "http://www.welivesecurity.com"
        reference2 = "https://www.welivesecurity.com/wp-content/uploads/2021/01/ESET_Kobalos.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $encrypted_strings_sizes = {
            05 00 00 00 09 00 00 00  04 00 00 00 06 00 00 00
            08 00 00 00 08 00 00 00  02 00 00 00 02 00 00 00
            01 00 00 00 01 00 00 00  05 00 00 00 07 00 00 00
            05 00 00 00 05 00 00 00  05 00 00 00 0A 00 00 00
        }
        $password_md5_digest = { 3ADD48192654BD558A4A4CED9C255C4C }
        $rsa_512_mod_header = { 10 11 02 00 09 02 00 }
        $strings_rc4_key = { AE0E05090F3AC2B50B1BC6E91D2FE3CE }

    condition:
        any of them
}

rule kobalos_ssh_credential_stealer {
    meta:
        description = "Kobalos SSH credential stealer seen in OpenSSH client"
        author = "Marc-Etienne M.Léveillé"
        date = "2020-11-02"
        reference = "http://www.welivesecurity.com"
        reference2 = "https://www.welivesecurity.com/wp-content/uploads/2021/01/ESET_Kobalos.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $ = "user: %.128s host: %.128s port %05d user: %.128s password: %.128s"

    condition:
        any of them
}

// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2018, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import "pe"

private rule not_ms {
    condition:
        not for any i in (0..pe.number_of_signatures - 1):
        (
            pe.signatures[i].issuer contains "Microsoft Corporation"
        )
}

rule turla_outlook_gen {
    meta:
        author      = "ESET Research"
        date        = "05-09-2018"
        description = "Turla Outlook malware"
        version     = 2
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"    
    strings:
        $s1 = "Outlook Express" ascii wide
        $s2 = "Outlook watchdog" ascii wide
        $s3 = "Software\\RIT\\The Bat!" ascii wide
        $s4 = "Mail Event Window" ascii wide
        $s5 = "Software\\Mozilla\\Mozilla Thunderbird\\Profiles" ascii wide
        $s6 = "%%PDF-1.4\n%%%c%c\n" ascii wide
        $s7 = "%Y-%m-%dT%H:%M:%S+0000" ascii wide
        $s8 = "rctrl_renwnd32" ascii wide
        $s9 = "NetUIHWND" ascii wide
        $s10 = "homePostalAddress" ascii wide
        $s11 = "/EXPORT;OVERRIDE;START=-%d;END=-%d;FOLDER=%s;OUT=" ascii wide
        $s12 = "Re:|FWD:|AW:|FYI:|NT|QUE:" ascii wide
        $s13 = "IPM.Note" ascii wide
        $s14 = "MAPILogonEx" ascii wide
        $s15 = "pipe\\The Bat! %d CmdLine" ascii wide
        $s16 = "PowerShellRunner.dll" ascii wide
        $s17 = "cmd container" ascii wide
        $s18 = "mapid.tlb" ascii wide nocase
        $s19 = "Content-Type: F)*+" ascii wide fullword
    condition:
        not_ms and 5 of them
}

rule turla_outlook_filenames {
    meta:
        author      = "ESET Research"
        date        = "22-08-2018"
        description = "Turla Outlook filenames"
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"   
    strings:
        $s1 = "mapid.tlb"
        $s2 = "msmime.dll"
        $s3 = "scawrdot.db"
    condition:
        any of them
}

rule turla_outlook_log {
    meta:
        author      = "ESET Research"
        date        = "22-08-2018"
        description = "First bytes of the encrypted Turla Outlook logs"
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"   
    strings:
        //Log begin: [...] TVer
        $s1 = {01 87 C9 75 C8 69 98 AC E0 C9 7B [21] EB BB 60 BB 5A}
    condition:
        $s1 at 0
}

rule turla_outlook_exports {
    meta:
        author      = "ESET Research"
        date        = "22-08-2018"
        description = "Export names of Turla Outlook Malware"
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"  
    condition:
        (pe.exports("install") or pe.exports("Install")) and
        pe.exports("TBP_Initialize") and
        pe.exports("TBP_Finalize") and
        pe.exports("TBP_GetName") and
        pe.exports("DllRegisterServer") and
        pe.exports("DllGetClassObject")
}

rule turla_outlook_pdf {
    meta:
        author      = "ESET Research"
        date        = "22-08-2018"
        description = "Detect PDF documents generated by Turla Outlook malware"
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"  
    strings:
        $s1 = "Adobe PDF Library 9.0" ascii wide nocase
        $s2 = "Acrobat PDFMaker 9.0"  ascii wide nocase
        $s3 = {FF D8 FF E0 00 10 4A 46 49 46}
        $s4 = {00 3F 00 FD FC A2 8A 28 03 FF D9}
        $s5 = "W5M0MpCehiHzreSzNTczkc9d" ascii wide nocase
        $s6 = "PDF-1.4" ascii wide nocase
    condition:
        5 of them
}

rule outlook_misty1 {
    meta:
        author      = "ESET Research"
        date        = "22-08-2018"
        description = "Detects the Turla MISTY1 implementation"             
        reference   = "https://www.welivesecurity.com/wp-content/uploads/2018/08/Eset-Turla-Outlook-Backdoor.pdf"
        source = "https://github.com/eset/malware-ioc/"
        contact = "github@eset.com"
        license = "BSD 2-Clause"  
    strings:
        //and     edi, 1FFh
        $o1 = {81 E7 FF 01 00 00}
        //shl     ecx, 9
        $s1 = {C1 E1 09}
        //xor     ax, si
        $s2 = {66 33 C6}
        //shr     eax, 7
        $s3 = {C1 E8 07}
        $o2 = {8B 11 8D 04 1F 50 03 D3 8D 4D C4}
    condition:
        $o2 and for all i in (1..#o1):
            (for all of ($s*) : ($ in (@o1[i] -500 ..@o1[i] + 500)))
}

// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2019, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

rule skip20_sqllang_hook
{
    meta:
    author      = "Mathieu Tartare <mathieu.tartare@eset.com>"
    date        = "21-10-2019"
    description = "YARA rule to detect if a sqllang.dll version is targeted by skip-2.0. Each byte pattern corresponds to a function hooked by skip-2.0. If $1_0 or $1_1 match, it is probably targeted as it corresponds to the hook responsible for bypassing the authentication."
    reference   = "https://www.welivesecurity.com/" 
    source = "https://github.com/eset/malware-ioc/"
    contact = "github@eset.com"
    license = "BSD 2-Clause"

    strings:
        $1_0  = {ff f3 55 56 57 41 56 48 81 ec c0 01 00 00 48 c7 44 24 38 fe ff ff ff}
        $1_1  = {48 8b c3 4c 8d 9c 24 a0 00 00 00 49 8b 5b 10 49 8b 6b 18 49 8b 73 20 49 8b 7b 28 49 8b e3 41 5e c3 90 90 90 90 90 90 90 ff 25}
        $2_0  = {ff f3 55 57 41 55 48 83 ec 58 65 48 8b 04 25 30 00 00 00}
        $2_1  = {48 8b 5c 24 30 48 8b 74 24 38 48 83 c4 20 5f c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 ff 25}
        $3_0  = {89 4c 24 08 4c 8b dc 49 89 53 10 4d 89 43 18 4d 89 4b 20 57 48 81 ec 90 00 00 00}
        $3_1  = {4c 8d 9c 24 20 01 00 00 49 8b 5b 40 49 8b 73 48 49 8b e3 41 5f 41 5e 41 5c 5f 5d c3}
        $4_0  = {ff f5 41 56 41 57 48 81 ec 90 00 00 00 48 8d 6c 24 50 48 c7 45 28 fe ff ff ff 48 89 5d 60 48 89 75 68 48 89 7d 70 4c 89 65 78}
        $4_1  = {8b c1 48 8b 8c 24 30 02 00 00 48 33 cc}
        $5_0  = {48 8b c4 57 41 54 41 55 41 56 41 57 48 81 ec 90 03 00 00 48 c7 80 68 fd ff ff fe ff ff ff 48 89 58 18 48 89 70 20}
        $5_1  = {48 c7 80 68 fd ff ff fe ff ff ff 48 89 58 18 48 89 70 20}
        $6_0  = {44 88 4c 24 20 44 89 44 24 18 48 89 54 24 10 48 89 4c 24 08 53 56 57 41 54 41 55 41 56 41 57 48 81 ec 80 01 00 00}
        $6_1  = {48 89 4c 24 08 53 56 57 41 54 41 55 41 56 41 57 48 81 ec 80 01 00 00 48 c7 84 24 e8 00 00 00 fe ff ff ff}
        $7_0  = {08 48 89 74 24 10 57 48 83 ec 20 49 63 d8 48 8b f2 48 8b f9 45 85 c0}
        $7_1  = {20 49 63 d8 48 8b f2 48 8b f9 45 85}
        $8_0  = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [11300-] ff f5 56 57 41 54 41 55 41 56 41 57 48 8b ec 48 83 ec 70}
        $9_0  = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [40050-] 48 8b c4 55 41 54 41 55 41 56 41 57 48 8b ec 48 83 ec 60}
        $10_0 = {41 56 48 83 ec 50 48 c7 44 24 20 fe ff ff ff 48 89 5c 24 60 48 89 6c 24 68 48 89 74 24 70 48 89 7c 24 78 48 8b d9 33 ed 8b f5 89 6c}
        $10_1 = {48 8b 42 18 4c 89 90 f0 00 00 00 44 89 90 f8 00 00 00 c7 80 fc 00 00 00 1b 00 00 00 48 8b c2 c3 90 90 90}
        $11_0 = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [40700-] 48 8b c4 55 41 54 41 55 41 56 41 57 48 8b ec 48 83 ec 60}
        $12_0 = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [10650-] 48 8b c4 55 41 54 41 55 41 56 41 57 48 8b ec 48 83 ec 60}
        $13_0 = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [41850-] ff f5 56 57 41 54 41 55 41 56 41 57 48 8b ec 48 83 ec 70}
        $14_0 = {48 89 01 48 8b c2 48 c7 41 08 04 00 00 00 c3 90 90 90 90 90 90 90 90 90 90 89 91 40 [42600-] ff f7 48 83 ec 50 48 c7 44 24 20 fe ff ff ff}

    condition:
        any of them
}


// Operation Potao yara rules
// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2015, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
private rule PotaoDecoy
{
    strings:
        $mz = { 4d 5a }
        $str1 = "eroqw11"
        $str2 = "2sfsdf"
        $str3 = "RtlDecompressBuffer"
        $wiki_str = "spanned more than 100 years and ruined three consecutive" wide

        $old_ver1 = {53 68 65 6C 6C 33 32 2E 64 6C 6C 00 64 61 66 73 72 00 00 00 64 61 66 73 72 00 00 00 64 6F 63 (00 | 78)}
        $old_ver2 = {6F 70 65 6E 00 00 00 00 64 6F 63 00 64 61 66 73 72 00 00 00 53 68 65 6C 6C 33 32 2E 64 6C 6C 00}       
    condition:
        ($mz at 0) and ( (all of ($str*)) or any of ($old_ver*) or $wiki_str )
}
private rule PotaoDll
{
    strings:
        $mz = { 4d 5a }
        
        $dllstr1 = "?AVCncBuffer@@"
        $dllstr2 = "?AVCncRequest@@"
        $dllstr3 = "Petrozavodskaya, 11, 9"
        $dllstr4 = "_Scan@0"
        $dllstr5 = "\x00/sync/document/"
        $dllstr6 = "\\temp.temp"
        
        $dllname1 = "node69MainModule.dll"
        $dllname2 = "node69-main.dll"
        $dllname3 = "node69MainModuleD.dll"
        $dllname4 = "task-diskscanner.dll"
        $dllname5 = "\x00Screen.dll"
        $dllname6 = "Poker2.dll"        
        $dllname7 = "PasswordStealer.dll"
        $dllname8 = "KeyLog2Runner.dll" 
        $dllname9 = "GetAllSystemInfo.dll"          
        $dllname10 = "FilePathStealer.dll"          
    condition:
        ($mz at 0) and (any of ($dllstr*) and any of ($dllname*))
}
private rule PotaoUSB
{
    strings:
        $mz = { 4d 5a }
        
        $binary1 = { 33 C0 8B C8 83 E1 03 BA ?? ?? ?? 00 2B D1 8A 0A 32 88 ?? ?? ?? 00 2A C8 FE C9 88 88 ?? ?? ?? 00 40 3D ?? ?? 00 00 7C DA C3 }
        $binary2 = { 55 8B EC 51 56 C7 45 FC 00 00 00 00 EB 09 8B 45 FC 83 C0 01 89 45 FC 81 7D FC ?? ?? 00 00 7D 3D 8B 4D FC 0F BE 89 ?? ?? ?? 00 8B 45 FC 33 D2 BE 04 00 00 00 F7 F6 B8 03 00 00 00 2B C2 0F BE 90 ?? ?? ?? 00 33 CA 2B 4D FC 83 E9 01 81 E1 FF 00 00 00 8B 45 FC 88 88 ?? ?? ?? 00 EB B1 5E 8B E5 5D C3}
    condition:
        ($mz at 0) and any of ($binary*)
}
private rule PotaoSecondStage
{
    strings:
        $mz = { 4d 5a }
        // hash of CryptBinaryToStringA and CryptStringToBinaryA
        $binary1 = {51 7A BB 85 [10-180] E8 47 D2 A8}
        // old hash of CryptBinaryToStringA and CryptStringToBinaryA
        $binary2 = {5F 21 63 DD [10-30] EC FD 33 02}
        $binary3 = {CA 77 67 57 [10-30] BA 08 20 7A}
        
        $str1 = "?AVCrypt32Import@@"
        $str2 = "%.5llx"
    condition:
        ($mz at 0) and any of ($binary*) and any of ($str*)
}
rule Potao
{
    meta:
        Author      = "Anton Cherepanov"
        Date        = "2015/07/29"
        Description = "Operation Potao"
        Reference   = "http://www.welivesecurity.com/wp-content/uploads/2015/07/Operation-Potao-Express_final_v2.pdf"
        Source = "https://github.com/eset/malware-ioc/"
        Contact = "threatintel@eset.com"
        License = "BSD 2-Clause"
    condition:
        PotaoDecoy or PotaoDll or PotaoUSB or PotaoSecondStage
}

// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These YARA rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2021, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import "pe"

private rule InvisiMole_Blob {
    meta:
        description = "Detects InvisiMole blobs by magic values"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $magic_old_32 = {F9 FF D0 DE}
        $magic_old_64 = {64 FF D0 DE}
        $magic_new_32 = {86 DA 11 CE}
        $magic_new_64 = {64 DA 11 CE}

    condition:
        ($magic_old_32 at 0) or ($magic_old_64 at 0) or ($magic_new_32 at 0) or ($magic_new_64 at 0)
}

rule apt_Windows_InvisiMole_Logs {
    meta:
        description = "Detects log files with collected created by InvisiMole's RC2CL backdoor"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    condition:
        uint32(0) == 0x08F1CAA1 or
        uint32(0) == 0x08F1CAA2 or
        uint32(0) == 0x08F1CCC0 or
        uint32(0) == 0x08F2AFC0 or
        uint32(0) == 0x083AE4DF or
        uint32(0) == 0x18F2CBB1 or
        uint32(0) == 0x1900ABBA or
        uint32(0) == 0x24F2CEA1 or
        uint32(0) == 0xDA012193 or
        uint32(0) == 0xDA018993 or
        uint32(0) == 0xDA018995 or
        uint32(0) == 0xDD018991
}

rule apt_Windows_InvisiMole_SFX_Dropper {

    meta:
        description = "Detects trojanized InvisiMole files: patched RAR SFX droppers with added InvisiMole blobs (config encrypted XOR 2A at the end of a file)"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $encrypted_config = {5F 59 4F 58 19 18 04 4E 46 46 2A 5D 59 5A 58 43 44 5E 4C 7D 2A 0F 2A 59 2A 78 2A 4B 2A 58 2A 0E 2A 6F 2A 72 2A 4B 2A 0F 2A 4E 2A 04 2A 0F 2A 4E 2A 76 2A 0F 2A 79 2A 2A 2A 79 42 4F 46 46 6F 52 4F 49 5F 5E 4F 7D 2A 79 42 4F 46 46 19 18 04 4E 46 46 2A 7C 43 58 5E 5F 4B 46 6B 46 46 45 49 2A 66 45 4B 4E 66 43 48 58 4B 58 53 6B}

    condition:
        uint16(0) == 0x5A4D and $encrypted_config
}

rule apt_Windows_InvisiMole_CPL_Loader {
    meta:
        description = "CPL loader"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "WScr%steObject(\"WScr%s.Run(\"::{20d04fe0-3a%s30309d}\\\\::{21EC%sDD-08002B3030%s\", 0);"
        $s2 = "\\Control.js" wide
        $s3 = "\\Control Panel.lnk" wide
        $s4 = "FPC 3.0.4 [2019/04/13] for x86_64 - Win64"
        $s5 = "FPC 3.0.4 [2019/04/13] for i386 - Win32"
        $s6 = "imageapplet.dat" wide
        $s7 = "wkssvmtx"

    condition:
        uint16(0) == 0x5A4D and (3 of them)
}

rule apt_Windows_InvisiMole_Wrapper_DLL {
    meta:
        description = "Detects InvisiMole wrapper DLL with embedded RC2CL and RC2FM backdoors, by export and resource names"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/2018/06/07/invisimole-equipped-spyware-undercover/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    condition:
        pe.exports("GetDataLength") and
        for any y in (0..pe.number_of_resources - 1): (
            pe.resources[y].type == pe.RESOURCE_TYPE_RCDATA and pe.resources[y].name_string == "R\x00C\x002\x00C\x00L\x00"
        ) and
        for any y in (0..pe.number_of_resources - 1): (
            pe.resources[y].type == pe.RESOURCE_TYPE_RCDATA and pe.resources[y].name_string == "R\x00C\x002\x00F\x00M\x00"
        )
}

rule apt_Windows_InvisiMole_DNS_Downloader {

    meta:
        description = "InvisiMole DNS downloader"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $d = "DnsQuery_A"

        $s1 = "Wireshark-is-running-{9CA78EEA-EA4D-4490-9240-FC01FCEF464B}" xor
        $s2 = "AddIns\\" ascii wide xor
        $s3 = "pcornomeex." xor
        $s4 = "weriahsek.rxe" xor
        $s5 = "dpmupaceex." xor
        $s6 = "TCPViewClass" xor
        $s7 = "PROCMON_WINDOW_CLASS" xor
        $s8 = "Key%C"
        $s9 = "AutoEx%C" xor
        $s10 = "MSO~"
        $s11 = "MDE~"
        $s12 = "DNS PLUGIN, Step %d" xor
        $s13 = "rundll32.exe \"%s\",StartUI"

    condition:
        ((uint16(0) == 0x5A4D) or InvisiMole_Blob) and $d and 5 of ($s*)
}

rule apt_Windows_InvisiMole_RC2CL_Backdoor {

    meta:
        description = "InvisiMole RC2CL backdoor"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "RC2CL" wide

        $s2 = "hp12KsNh92Dwd" wide
        $s3 = "ZLib package %s: files: %d, total size: %d" wide
        $s4 = "\\Un4seen" wide
        $s5 = {9E 01 3A AD} // encryption key

        $s6 = "~mrc_" wide
        $s7 = "~src_" wide
        $s8 = "~wbc_" wide
        $s9 = "zdf_" wide
        $s10 = "~S0PM" wide
        $s11 = "~A0FM" wide
        $s12 = "~70Z63\\" wide
        $s13 = "~E070C" wide
        $s14 = "~N031E" wide

        $s15 = "%szdf_%s.data" wide
        $s16 = "%spicture.crd" wide
        $s17 = "%s70zf_%s.cab" wide
        $s18 = "%spreview.crd" wide

        $s19 = "Value_Bck" wide
        $s20 = "Value_WSFX_ZC" wide
        $s21 = "MachineAccessStateData" wide
        $s22 = "SettingsSR2" wide

    condition:
        ((uint16(0) == 0x5A4D) or InvisiMole_Blob) and 5 of ($s*)
}

rule apt_Windows_InvisiMole {

    meta:
        description = "InvisiMole magic values, keys and strings"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "CryptProtectData"
        $s2 = "CryptUnprotectData"
        $s3 = {9E 01 3A AD}
        $s4 = "GET /getversion2a/%d%.2X%.2X/U%sN HTTP/1.1"
        $s5 = "PULSAR_LOADER.dll"

        /*
        cmp reg, 0DED0FFF9h
        */
        $check_magic_old_32 = {3? F9 FF D0 DE}

        /*
        cmp reg, 0DED0FF64h
        */
        $check_magic_old_64 = {3? 64 FF D0 DE}

        /*
        cmp dword ptr [reg], 0CE11DA86h
        */
        $check_magic_new_32 = {81 3? 86 DA 11 CE}

        /*
        cmp dword ptr [reg], 0CE11DA64h
        */
        $check_magic_new_64 = {81 3? 64 DA 11 CE}

    condition:
        ((uint16(0) == 0x5A4D) or InvisiMole_Blob) and (any of ($check_magic*)) and (2 of ($s*))
}

rule apt_Windows_InvisiMole_C2 {

    meta:
        description = "InvisiMole C&C servers"
        author = "ESET Research"
        date = "2021-05-17"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2020/06/ESET_InvisiMole.pdf"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "46.165.220.228" ascii wide
        $s2 = "80.255.3.66" ascii wide
        $s3 = "85.17.26.174" ascii wide
        $s4 = "185.193.38.55" ascii wide
        $s5 = "194.187.249.157"  ascii wide
        $s6 = "195.154.255.211"  ascii wide
        $s7 = "153.re"  ascii wide fullword
        $s8 = "adstat.red"  ascii wide
        $s9 = "adtrax.net"  ascii wide
        $s10 = "akamai.sytes.net"  ascii wide
        $s11 = "amz-eu401.com"  ascii wide
        $s12 = "blabla234342.sytes.net"  ascii wide
        $s13 = "mx1.be"  ascii wide fullword
        $s14 = "statad.de"  ascii wide
        $s15 = "time.servehttp.com"  ascii wide
        $s16 = "upd.re"  ascii wide fullword
        $s17 = "update.xn--6frz82g"  ascii wide
        $s18 = "updatecloud.sytes.net"  ascii wide
        $s19 = "updchecking.sytes.net"  ascii wide
        $s20 = "wlsts.net"  ascii wide
        $s21 = "ro2.host"  ascii wide fullword
        $s22 = "2ld.xyz"  ascii wide fullword
        $s23 = "the-haba.com"  ascii wide
        $s24 = "82.202.172.134"  ascii wide
        $s25 = "update.xn--6frz82g"  ascii wide

    condition:
        ((uint16(0) == 0x5A4D) or InvisiMole_Blob) and $s21 and any of them
}

// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2021, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import "pe"
rule SparklingGoblin_ChaCha20Loader_RichHeader
{
    meta:
        author = "ESET Research"
        copyright = "ESET Research"
        description = "Rule matching ChaCha20 loaders rich header"
        date = "2021-03-30"
        reference = "http://welivesecurity.com/2021/08/24/sidewalk-may-be-as-dangerous-as-crosswalk/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"

        hash = "09FFE37A54BC4EBEBD8D56098E4C76232F35D821"
        hash = "29B147B76BB0D9E09F7297487CB972E6A2905586"
        hash = "33F2C3DE2457B758FC5824A2B253AD7C7C2E9E37"
        hash = "45BEF297CE78521EAC6EE39E7603E18360E67C5A"
        hash = "4CEC7CDC78D95C70555A153963064F216DAE8799"
        hash = "4D4C1A062A0390B20732BA4D65317827F2339B80"
        hash = "4F6949A4906B834E83FF951E135E0850FE49D5E4"

    condition:
        pe.rich_signature.length >= 104 and pe.rich_signature.length <= 112 and
        pe.rich_signature.toolid(241, 40116) >= 5 and pe.rich_signature.toolid(241, 40116) <= 10  and
        pe.rich_signature.toolid(147, 30729) == 11 and
        pe.rich_signature.toolid(264, 24215) >= 15 and pe.rich_signature.toolid(264, 24215) <= 16 
}

rule SparklingGoblin_ChaCha20
{
    meta:
        author = "ESET Research"
        copyright = "ESET Research"
        description = "SparklingGoblin ChaCha20 implementations"
        date = "2021-05-20"
        reference = "http://welivesecurity.com/2021/08/24/sidewalk-may-be-as-dangerous-as-crosswalk/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"

        hash = "2EDBEA43F5C40C867E5B6BBD93CC972525DF598B"
        hash = "B6D245D3D49B06645C0578804064CE0C072CBE0F"
        hash = "8BE6D5F040D0085C62B1459AFC627707B0DE89CF"
        hash = "4668302969FE122874FB2447A80378DCB671C86B"
        hash = "9BDECB08E16A23D271D0A3E836D9E7F83D7E2C3B"
        hash = "9CE7650F2C08C391A35D69956E171932D116B8BD"
        hash = "91B32E030A1F286E7D502CA17E107D4BFBD7394A"

    strings:
        // 32-bits version
        $chunk_1 = {
            8B 4D ??
            56
            8B 75 ??
            57
            8B 7D ??
            8B 04 BB
            01 04 93
            8B 04 B3
            33 04 93
            C1 C0 10
            89 04 B3
            01 04 8B
            8B 04 BB
            33 04 8B
            C1 C0 0C
            89 04 BB
            01 04 93
            8B 04 B3
            33 04 93
            C1 C0 08
            89 04 B3
            01 04 8B
            8B 04 BB
            33 04 8B
            C1 C0 07
            89 04 BB
        }
        // 64-bits version
        $chunk_2 = {
            03 4D ??
            44 03 C0
            03 55 ??
            33 F1
            45 33 D8
            C1 C6 10
            44 33 F2
            41 C1 C3 10
            41 03 FB
            41 C1 C6 10
            45 03 E6
            41 03 DA
            44 33 CB
            44 03 EE
            41 C1 C1 10
            8B C7
            33 45 ??
            45 03 F9
            C1 C0 0C
            44 03 C0
            45 33 D8
            44 89 45 ??
            41 C1 C3 08
            41 03 FB
            44 8B C7
            44 33 C0
            41 8B C5
            33 45 ??
            C1 C0 0C
            03 C8
            41 C1 C0 07
            33 F1
            89 4D ??
            C1 C6 08
            44 03 EE
            41 8B CD
            33 C8
            41 8B C4
            33 45 ??
            C1 C0 0C
            03 D0
            C1 C1 07
            44 33 F2
            89 55 ??
            41 C1 C6 08
            45 03 E6
            41 8B D4
            33 D0
            41 8B C7
            41 33 C2
            C1 C2 07
            C1 C0 0C
            03 D8
            44 33 CB
            41 C1 C1 08
            45 03 F9
            45 8B D7
            44 33 D0
            8B 45 ??
            03 C1
            41 C1 C2 07
            44 33 C8
            89 45 ??
            41 C1 C1 10
            45 03 E1
            41 8B C4
            33 C1
            8B 4D ??
            C1 C0 0C
            03 C8
            44 33 C9
            89 4D ??
            89 4D ??
            41 C1 C1 08
            45 03 E1
            41 8B CC
            33 C8
            8B 45 ??
            C1 C1 07
            89 4D ??
            89 4D ??
            03 C2
            41 03 D8
            89 45 ??
            41 33 C3
            C1 C0 10
            44 03 F8
            41 8B CF
            33 CA
            8B 55 ??
        }
        $chunk_3 = {
            C7 45 ?? 65 78 70 61
            4C 8D 45 ??
            C7 45 ?? 6E 64 20 33
            4D 8B F9
            C7 45 ?? 32 2D 62 79
            4C 2B C1
            C7 45 ?? 74 65 20 6B
        }
        $chunk_4 = {
            0F B6 02
            0F B6 4A ??
            C1 E1 08
            0B C8
            0F B6 42 ??
            C1 E1 08
            0B C8
            0F B6 42 ??
            C1 E1 08
            0B C8
            41 89 0C 10
            48 8D 52 ??
            49 83 E9 01
        }
        // 64-bits version
        $chunk_5 = {
            03 4D ??
            44 03 C0
            03 55 ??
            33 F1
            41 33 F8
            C1 C6 10
            44 33 F2
            C1 C7 10
            44 03 DF
            41 C1 C6 10
            45 03 E6
            44 03 CB
            45 33 D1
            44 03 EE
            41 C1 C2 10
            41 8B C3
            33 45 ??
            45 03 FA
            C1 C0 0C
            44 03 C0
            41 33 F8
            44 89 45 ??
            C1 C7 08
            44 03 DF
            45 8B C3
            44 33 C0
            41 8B C5
            33 45 ??
            C1 C0 0C
            03 C8
            41 C1 C0 07
            33 F1
            89 4D ??
            C1 C6 08
            44 03 EE
            41 8B CD
            33 C8
            41 8B C4
            33 45 ??
            C1 C0 0C
            03 D0
            C1 C1 07
            44 33 F2
            89 55 ??
            41 C1 C6 08
            45 03 E6
            41 8B D4
            33 D0
            41 8B C7
            33 C3
            C1 C2 07
            C1 C0 0C
            44 03 C8
            45 33 D1
            41 C1 C2 08
            45 03 FA
            41 8B DF
            33 D8
            8B 45 ??
            03 C1
            C1 C3 07
            44 33 D0
            89 45 ??
            41 C1 C2 10
            45 03 E2
            41 8B C4
            33 C1
            8B 4D ??
            C1 C0 0C
            03 C8
            44 33 D1
            89 4D ??
            89 4D ??
            41 C1 C2 08
            45 03 E2
            41 8B CC
            33 C8
            8B 45 ??
            C1 C1 07
            89 4D ??
            89 4D ??
            03 C2
            45 03 C8
            89 45 ??
            33 C7
            C1 C0 10
            44 03 F8
            41 8B CF
            33 CA
            8B 55 ??
            C1 C1 0C
            03 D1
            8B FA
            89 55 ??
            33 F8
            89 55 ??
            8B 55 ??
            03 D3
            C1 C7 08
            44 03 FF
            41 8B C7
            33 C1
            C1 C0 07
            89 45 ??
            89 45 ??
            8B C2
            33 C6
            C1 C0 10
            44 03 D8
            41 33 DB
            C1 C3 0C
            03 D3
            8B F2
            89 55 ??
            33 F0
            41 8B C1
            41 33 C6
            C1 C6 08
            C1 C0 10
            44 03 DE
            44 03 E8
            41 33 DB
            41 8B CD
            C1 C3 07
            41 33 C8
            44 8B 45 ??
            C1 C1 0C
            44 03 C9
            45 8B F1
            44 33 F0
            41 C1 C6 08
            45 03 EE
            41 8B C5
            33 C1
            8B 4D ??
            C1 C0 07
        }

    condition:
        any of them and filesize < 450KB

}

rule SparklingGoblin_EtwEventWrite
{
    meta:
        author = "ESET Research"
        copyright = "ESET Research"
        description = "SparklingGoblin EtwEventWrite patching"
        date = "2021-05-20"
        reference = "http://welivesecurity.com/2021/08/24/sidewalk-may-be-as-dangerous-as-crosswalk/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"

        hash = "2EDBEA43F5C40C867E5B6BBD93CC972525DF598B"
        hash = "B6D245D3D49B06645C0578804064CE0C072CBE0F"
        hash = "8BE6D5F040D0085C62B1459AFC627707B0DE89CF"
        hash = "4668302969FE122874FB2447A80378DCB671C86B"
        hash = "9BDECB08E16A23D271D0A3E836D9E7F83D7E2C3B"
        hash = "9CE7650F2C08C391A35D69956E171932D116B8BD"

    strings:
        // 64-bits version
        $chunk_1 = {
            48 8D 0D ?? ?? ?? ??
            C7 44 24 ?? 48 31 C0 C3
            FF 15 ?? ?? ?? ??
            48 8B C8
            48 8D 15 ?? ?? ?? ??
            FF 15 ?? ?? ?? ??
            83 64 24 ?? 00
            4C 8D 4C 24 ??
            BF 04 00 00 00
            48 8B C8
            8B D7
            48 8B D8
            44 8D 47 ??
            FF 15 ?? ?? ?? ??
            44 8B C7
            48 8D 54 24 ??
            48 8B CB
            E8 ?? ?? ?? ??
            44 8B 44 24 ??
            4C 8D 4C 24 ??
            8B D7
            48 8B CB
            FF 15 ?? ?? ?? ??
            48 8B 05 ?? ?? ?? ??
        }
        // 32-bits version
        $chunk_2 = {
            55
            8B EC
            51
            51
            57
            68 08 1A 41 00
            66 C7 45 ?? C2 14
            C6 45 ?? 00
            FF 15 ?? ?? ?? ??
            68 10 1A 41 00
            50
            FF 15 ?? ?? ?? ??
            83 65 ?? 00
            8B F8
            8D 45 ??
            50
            6A 40
            6A 03
            57
            FF 15 ?? ?? ?? ??
            6A 03
            8D 45 ??
            50
            57
            E8 ?? ?? ?? ??
            83 C4 0C
            8D 45 ??
            50
            FF 75 ??
            6A 03
            57
            FF 15 ?? ?? ?? ??
        }
        // 64-bits version
        $chunk_3 = {
            48 8D 0D ?? ?? ?? ??
            C7 44 24 ?? 48 31 C0 C3
            FF 15 ?? ?? ?? ??
            48 8B C8
            48 8D 15 ?? ?? ?? ??
            FF 15 ?? ?? ?? ??
        }

    condition:
        any of them
}

rule SparklingGoblin_Mutex
{
    meta:
        author = "ESET Research"
        copyright = "ESET Research"
        description = "SparklingGoblin ChaCha20 loaders mutexes"
        date = "2021-05-20"
        reference = "http://welivesecurity.com/2021/08/24/sidewalk-may-be-as-dangerous-as-crosswalk/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"

        hash = "2EDBEA43F5C40C867E5B6BBD93CC972525DF598B"
        hash = "B6D245D3D49B06645C0578804064CE0C072CBE0F"
        hash = "8BE6D5F040D0085C62B1459AFC627707B0DE89CF"
        hash = "4668302969FE122874FB2447A80378DCB671C86B"
        hash = "9BDECB08E16A23D271D0A3E836D9E7F83D7E2C3B"
        hash = "9CE7650F2C08C391A35D69956E171932D116B8BD"

    strings:
        $mutex_1 = "kREwdFrOlvASgP4zWZyV89m6T2K0bIno"
        $mutex_2 = "v5EPQFOImpTLaGZes3Nl1JSKHku8AyCw"

    condition:
        any of them
}


// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These yara rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2018, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

private rule ssh_client : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH client (ssh)"
        author = "Marc-Etienne M.Leveille"
        email  = "leveille@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $usage = "usage: ssh ["
        $old_version = "-L listen-port:host:port"

    condition:
        $usage or $old_version
}

private rule ssh_daemon : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH daemon (sshd)"
        author = "Marc-Etienne M.Leveille"
        email  = "leveille@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $usage = "usage: sshd ["
        $old_version = "Listen on the specified port (default: 22)"

    condition:
        $usage or $old_version
}

private rule ssh_add : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH add (ssh-add)"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $usage = "usage: %s [options] [file ...]\n"
        $log = "Could not open a connection to your authentication agent.\n"

    condition:
        $usage and $log
}

private rule ssh_agent : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH agent (ssh-agent)"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $usage = "usage: %s [options] [command [arg ...]]"

    condition:
        $usage
}

private rule ssh_askpass : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH daemon (sshd)"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $pass = "Enter your OpenSSH passphrase:"
        $log = "Could not grab %s. A malicious client may be eavesdropping on you"

    condition:
        $pass and $log
}

private rule ssh_keygen : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH keygen (ssh-keygen)"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $pass = "Enter new passphrase (empty for no passphrase):"
        $log = "revoking certificates by key ID requires specification of a CA key"

    condition:
        $pass and $log
}

private rule ssh_keyscan : sshdoor {
    meta:
        description = "Signature to match the clean (or not) OpenSSH keyscan (ssh-keyscan)"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $usage = "usage: %s [-46Hv] [-f file] [-p port] [-T timeout] [-t type]"

    condition:
        $usage
}

private rule ssh_binary : sshdoor {
    meta:
        description = "Signature to match any clean (or not) SSH binary"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"

    condition:
        ssh_client or ssh_daemon or ssh_add or ssh_askpass or ssh_keygen or ssh_keyscan
}

private rule stack_string {
    meta:
        description = "Rule to detect use of string-stacking"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        // single byte offset from base pointer
        $bp = /(\xC6\x45.{2}){25}/
        // dword ss with single byte offset from base pointer
        $bp_dw = /(\xC7\x45.{5}){20}/
        // 4-bytes offset from base pointer
        $bp_off = /(\xC6\x85.{5}){25}/
        // single byte offset from stack pointer
        $sp = /(\xC6\x44\x24.{2}){25}/
        // 4-bytes offset from stack pointer
        $sp_off = /(\xC6\x84\x24.{5}){25}/

    condition:
        any of them
}

rule abafar {
    meta:
        description = "Rule to detect Abafar family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log_c =  "%s:%s@%s"
        $log_d =  "%s:%s from %s"

    condition:
        ssh_binary and any of them
}

rule akiva {
    meta:
        description = "Rule to detect Akiva family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = /(To|From):\s(%s\s\-\s)?%s:%s\n/

    condition:
        ssh_binary and $log
}

rule alderaan {
    meta:
        description = "Rule to detect Alderaan family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = /login\s(in|at):\s(%s\s)?%s:%s\n/

    condition:
        ssh_binary and $log
}

rule ando {
    meta:
        description = "Rule to detect Ando family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $s1 = "%s:%s\n"
        $s2 = "HISTFILE"
        $i = "fopen64"
        $m1 = "cat "
        $m2 = "mail -s"

    condition:
        ssh_binary and all of ($s*) and ($i or all of ($m*))
}

rule anoat {
    meta:
        description = "Rule to detect Anoat family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = "%s at: %s | user: %s, pass: %s\n"

    condition:
        ssh_binary and $log
}

rule atollon {
    meta:
        description = "Rule to detect Atollon family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $f1 = "PEM_read_RSA_PUBKEY"
        $f2 = "RAND_add"
        $log = "%s:%s"
        $rand = "/dev/urandom"

    condition:
        ssh_binary and stack_string and all of them
}

rule batuu {
    meta:
        description = "Rule to detect Batuu family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $args = "ssh: ~(av[%d]: %s\n)"
        $log = "readpass: %s\n"

    condition:
        ssh_binary and any of them
}

rule bespin {
    meta:
        description = "Rule to detect Bespin family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log1 = "%Y-%m-%d %H:%M:%S"
        $log2 = "%s %s%s"
        $log3 = "[%s]"

    condition:
        ssh_binary and all of them
}

rule bonadan {
    meta:
        description = "Rule to detect Bonadan family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $s1 = "g_server"
        $s2 = "mine.sock"
        $s3 = "tspeed"
        $e1 = "6106#x=%d#%s#%s#speed=%s"
        $e2 = "usmars.mynetgear.com"
        $e3 = "user=%s#os=%s#eip=%s#cpu=%s#mem=%s"

    condition:
        ssh_binary and any of them
}

rule borleias {
    meta:
        description = "Rule to detect Borleias family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = "%Y-%m-%d %H:%M:%S [%s]"

    condition:
        ssh_binary and all of them
}

rule chandrila {
    meta:
        description = "Rule to detect Chandrila family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = "S%s %s:%s"
        $magic = { 05 71 92 7D }

    condition:
        ssh_binary and all of them
}

rule coruscant {
    meta:
        description = "Rule to detect Coruscant family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $s1 = "%s:%s@%s\n"
        $s2 = "POST"
        $s3 = "HTTP/1.1"

    condition:
        ssh_binary and all of them
}

rule crait {
    meta:
        description = "Signature to detect Crait family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $i1 = "flock"
        $i2 = "fchmod"
        $i3 = "sendto"

    condition:
        ssh_binary and 2 of them
}

rule endor {
    meta:
        description = "Rule to detect Endor family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $u = "user: %s"
        $p = "password: %s"

    condition:
        ssh_binary and $u and $p in (@u..@u+20)
}

rule jakuu {
    meta:
        description = "Rule to detect Jakuu family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        notes = "Strings can be encrypted"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $dec = /GET\s\/\?(s|c)id=/
        $enc1 = "getifaddrs"
        $enc2 = "usleep"
        $ns = "gethostbyname"
        $log = "%s:%s"
        $rc4 = { A1 71 31 17 11 1A 22 27 55 00 66 A3 10 FE C2 10 22 32 6E 95 90 84 F9 11 73 62 95 5F 4D 3B DB DC }

    condition:
        ssh_binary and $log and $ns and ($dec or all of ($enc*) or $rc4)
}

rule kamino {
    meta:
        description = "Rule to detect Kamino family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $s1 = "/var/log/wtmp"
        $s2 = "/var/log/secure"
        $s3 = "/var/log/auth.log"
        $s4 = "/var/log/messages"
        $s5 = "/var/log/audit/audit.log"
        $s6 = "/var/log/httpd-access.log"
        $s7 = "/var/log/httpd-error.log"
        $s8 = "/var/log/xferlog"
        $i1 = "BIO_f_base64"
        $i2 = "PEM_read_bio_RSA_PUBKEY"
        $i3 = "srand"
        $i4 = "gethostbyname"

    condition:
        ssh_binary and 5 of ($s*) and 3 of ($i*)
}

rule kessel {
    meta:
        description = "Rule to detect Kessel family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $rc4 = "Xee5chu1Ohshasheed1u"
        $s1 = "ssh:%s:%s:%s:%s"
        $s2 = "sshkey:%s:%s:%s:%s:%s"
        $s3 = "sshd:%s:%s"
        $i1 = "spy_report"
        $i2 = "protoShellCMD"
        $i3 = "protoUploadFile"
        $i4 = "protoSendReport"
        $i5 = "tunRecvDNS"
        $i6 = "tunPackMSG"

    condition:
        ssh_binary and (2 of ($s*) or 2 of ($i*) or $rc4)
}

rule mimban {
    meta:
        description = "Rule to detect Mimban family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $s1 = "<|||%s|||%s|||%d|||>"
        $s2 = />\|\|\|%s\|\|\|%s\|\|\|\d\|\|\|%s\|\|\|%s\|\|\|%s\|\|\|%s\|\|\|</
        $s3 = "-----BEGIN PUBLIC KEY-----"
        $i1 = "BIO_f_base64"
        $i2 = "PEM_read_bio_RSA_PUBKEY"
        $i3 = "gethostbyname"

    condition:
        ssh_binary and 2 of ($s*) and 2 of ($i*)
}

rule ondaron {
    meta:
        description = "Rule to detect Ondaron family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $daemon = "user:password --> %s:%s\n"
        $client = /user(,|:)(a,)?password@host \-\-> %s(,|:)(b,)?%s@%s\n/

    condition:
        ssh_binary and ($daemon or $client)
}

rule polis_massa {
    meta:
        description = "Rule to detect Polis Massa family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = /\b\w+(:|\s-+>)\s%s(:%d)?\s\t(\w+)?:\s%s\s\t(\w+)?:\s%s/

    condition:
        ssh_binary and $log
}

rule quarren {
    meta:
        description = "Rule to detect Quarren family"
        author = "Hugo Porcher"
        email  = "hugo.porcher@eset.com"
        reference = "https://www.welivesecurity.com/wp-content/uploads/2018/12/ESET-The_Dark_Side_of_the_ForSSHe.pdf"
        date = "2018-12-05"
        license = "BSD 2-Clause"

    strings:
        $log = "h: %s, u: %s, p: %s\n"

    condition:
        ssh_binary and $log
}

// For feedback or questions contact us at: github@eset.com
// https://github.com/eset/malware-ioc/
//
// These YARA rules are provided to the community under the two-clause BSD
// license as follows:
//
// Copyright (c) 2021, ESET
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import "pe"

private rule IIS_Native_Module {
    meta:
        description = "Signature to match an IIS native module (clean or malicious)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $e1 = "This module subscribed to event"
        $e2 = "CHttpModule::OnBeginRequest"
        $e3 = "CHttpModule::OnPostBeginRequest"
        $e4 = "CHttpModule::OnAuthenticateRequest"
        $e5 = "CHttpModule::OnPostAuthenticateRequest"
        $e6 = "CHttpModule::OnAuthorizeRequest"
        $e7 = "CHttpModule::OnPostAuthorizeRequest"
        $e8 = "CHttpModule::OnResolveRequestCache"
        $e9 = "CHttpModule::OnPostResolveRequestCache"
        $e10 = "CHttpModule::OnMapRequestHandler"
        $e11 = "CHttpModule::OnPostMapRequestHandler"
        $e12 = "CHttpModule::OnAcquireRequestState"
        $e13 = "CHttpModule::OnPostAcquireRequestState"
        $e14 = "CHttpModule::OnPreExecuteRequestHandler"
        $e15 = "CHttpModule::OnPostPreExecuteRequestHandler"
        $e16 = "CHttpModule::OnExecuteRequestHandler"
        $e17 = "CHttpModule::OnPostExecuteRequestHandler"
        $e18 = "CHttpModule::OnReleaseRequestState"
        $e19 = "CHttpModule::OnPostReleaseRequestState"
        $e20 = "CHttpModule::OnUpdateRequestCache"
        $e21 = "CHttpModule::OnPostUpdateRequestCache"
        $e22 = "CHttpModule::OnLogRequest"
        $e23 = "CHttpModule::OnPostLogRequest"
        $e24 = "CHttpModule::OnEndRequest"
        $e25 = "CHttpModule::OnPostEndRequest"
        $e26 = "CHttpModule::OnSendResponse"
        $e27 = "CHttpModule::OnMapPath"
        $e28 = "CHttpModule::OnReadEntity"
        $e29 = "CHttpModule::OnCustomRequestNotification"
        $e30 = "CHttpModule::OnAsyncCompletion"
        $e31 = "CGlobalModule::OnGlobalStopListening"
        $e32 = "CGlobalModule::OnGlobalCacheCleanup"
        $e33 = "CGlobalModule::OnGlobalCacheOperation"
        $e34 = "CGlobalModule::OnGlobalHealthCheck"
        $e35 = "CGlobalModule::OnGlobalConfigurationChange"
        $e36 = "CGlobalModule::OnGlobalFileChange"
        $e37 = "CGlobalModule::OnGlobalApplicationStart"
        $e38 = "CGlobalModule::OnGlobalApplicationResolveModules"
        $e39 = "CGlobalModule::OnGlobalApplicationStop"
        $e40 = "CGlobalModule::OnGlobalRSCAQuery"
        $e41 = "CGlobalModule::OnGlobalTraceEvent"
        $e42 = "CGlobalModule::OnGlobalCustomNotification"
        $e43 = "CGlobalModule::OnGlobalThreadCleanup"
        $e44 = "CGlobalModule::OnGlobalApplicationPreload"    
    
    condition:
        uint16(0) == 0x5A4D and pe.exports("RegisterModule") and any of ($e*)
}

rule IIS_Group01_IISRaid {

    meta:
        description = "Detects Group 1 native IIS malware family (IIS-Raid derivates)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "cmd.exe" ascii wide
        $s2 = "CMD"
        $s3 = "PIN"
        $s4 = "INJ"
        $s5 = "DMP"
        $s6 = "UPL"
        $s7 = "DOW"
        $s8 = "C:\\Windows\\System32\\credwiz.exe" ascii wide
        
        $p1 = "C:\\Windows\\Temp\\creds.db"
        $p2 = "C:\\Windows\\Temp\\thumbs.db"
        $p3 = "C:\\Windows\\Temp\\AAD30E0F.tmp"
        $p4 = "X-Chrome-Variations"
        $p5 = "X-Cache"
        $p6 = "X-Via"
        $p7 = "COM_InterProt"
        $p8 = "X-FFEServer"
        $p9 = "X-Content-Type-Options"
        $p10 = "Strict-Transport-Security"
        $p11 = "X-Password"
        $p12 = "XXXYYY-Ref"
        $p13 = "X-BLOG"
        $p14 = "X-BlogEngine"

    condition:
        IIS_Native_Module and 3 of ($s*) and any of ($p*)
}

rule IIS_Group02 {

    meta:
        description = "Detects Group 2 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "HttpModule.pdb" ascii wide
        $s2 = "([\\w+%]+)=([^&]*)"
        $s3 = "([\\w+%]+)=([^!]*)"
        $s4 = "cmd.exe"
        $s5 = "C:\\Users\\Iso\\Documents\\Visual Studio 2013\\Projects\\IIS 5\\x64\\Release\\Vi.pdb" ascii wide
        $s6 = "AVRSAFunction"

    condition:
        IIS_Native_Module and 3 of ($s*)
}

rule IIS_Group03 {

    meta:
        description = "Detects Group 3 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "IIS-Backdoor.dll" 
        $s2 = "CryptStringToBinaryA"
        $s3 = "CreateProcessA"
        $s4 = "X-Cookie"

    condition:
        IIS_Native_Module and 3 of ($s*)
}

rule IIS_Group04_RGDoor {

    meta:
        description = "Detects Group 4 native IIS malware family (RGDoor)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        reference = "https://unit42.paloaltonetworks.com/unit42-oilrig-uses-rgdoor-iis-backdoor-targets-middle-east/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $i1 = "RGSESSIONID="
        $s2 = "upload$"
        $s3 = "download$"
        $s4 = "cmd$"
        $s5 = "cmd.exe"

    condition:
        IIS_Native_Module and ($i1 or all of ($s*))
}

rule IIS_Group05_IIStealer {

    meta:
        description = "Detects Group 5 native IIS malware family (IIStealer)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "tojLrGzFMbcDTKcH" ascii wide
        $s2 = "4vUOj3IutgtrpVwh" ascii wide
        $s3 = "SoUnRCxgREXMu9bM" ascii wide
        $s4 = "9Zr1Z78OkgaXj1Xr" ascii wide
        $s5 = "cache.txt" ascii wide
        $s6 = "/checkout/checkout.aspx" ascii wide
        $s7 = "/checkout/Payment.aspx" ascii wide
        $s8 = "/privacy.aspx"
        $s9 = "X-IIS-Data"
        $s10 = "POST"

        // string stacking of "/checkout/checkout.aspx"
        $s11 = {C7 ?? CF 2F 00 63 00 C7 ?? D3 68 00 65 00 C7 ?? D7 63 00 6B 00 C7 ?? DB 6F 00 75 00 C7 ?? DF 74 00 2F 00 C7 ?? E3 63 00 68 00 C7 ?? E7 65 00 63 00 C7 ?? EB 6B 00 6F 00 C7 ?? EF 75 00 74 00 C7 ?? F3 2E 00 61 00 C7 ?? F7 73 00 70 00 C7 ?? FB 78 00 00 00}

        // string stacking of "/privacy.aspx"
        $s12 = {C7 ?? AF 2F 00 70 00 C7 ?? B3 72 00 69 00 C7 ?? B7 76 00 61 00 C7 ?? BB 63 00 79 00 C7 ?? BF 2E 00 61 00 C7 ?? C3 73 00 70 00 C7 ?? C7 78 00 00 00}

    condition:
        IIS_Native_Module and 3 of ($s*)
}

rule IIS_Group06_ISN {

    meta:
        description = "Detects Group 6 native IIS malware family (ISN)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        reference = "https://www.trustwave.com/en-us/resources/blogs/spiderlabs-blog/the-curious-case-of-the-malicious-iis-module/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "isn7 config reloaded"
        $s2 = "isn7 config NOT reloaded, not found or empty"
        $s3 = "isn7 log deleted"
        $s4 = "isn7 log not deleted, ERROR 0x%X"
        $s5 = "isn7 log NOT found"
        $s6 = "isn_reloadconfig"
        $s7 = "D:\\soft\\Programming\\C++\\projects\\isapi\\isn7"
        $s8 = "get POST failed %d"
        $s9 = "isn7.dll"

    condition:
        IIS_Native_Module and 3 of ($s*)
}

rule IIS_Group07_IISpy {

    meta:
        description = "Detects Group 7 native IIS malware family (IISpy)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $s1 = "/credential/username"
        $s2 = "/credential/password"
        $s3 = "/computer/domain"
        $s4 = "/computer/name"
        $s5 = "/password"
        $s6 = "/cmd"
        $s7 = "%.8s%.8s=%.8s%.16s%.8s%.16s"
        $s8 = "ImpersonateLoggedOnUser"
        $s9 = "WNetAddConnection2W"

        $t1 = "X-Forwarded-Proto"
        $t2 = "Sec-Fetch-Mode"
        $t3 = "Sec-Fetch-Site"
        $t4 = "Cookie"

        // PNG IEND
        $t5 = {49 45 4E 44 AE 42 60 82}

        // PNG HEADER
        $t6 = {89 50 4E 47 0D 0A 1A 0A 00 00 00 0D 49 48 44 52}

    condition:
        IIS_Native_Module and 2 of ($s*) and any of ($t*)
}

rule IIS_Group08 {

    meta:
        description = "Detects Group 8 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings:
        $i1 = "FliterSecurity.dll"
        $i2 = "IIS7NativeModule.dll"
        $i3 = "Ver1.0."

        $s1 = "Cmd"
        $s2 = "Realy path : %s"
        $s3 = "Logged On Users : %d"
        $s4 = "Connect OK!"
        $s5 = "You are fucked!"
        $s6 = "Shit!Error"
        $s7 = "Where is the God!!"
        $s8 = "Shit!Download False!"
        $s9 = "Good!Run OK!"
        $s10 = "Shit!Run False!"
        $s11 = "Good!Download OK!"
        $s12 = "[%d]safedog"
        $s13 = "ed81bfc09d069121"
        $s14 = "a9478ef01967d190"
        $s15 = "af964b7479e5aea2"
        $s16 = "1f9e6526bea65b59"
        $s17 = "2b9e9de34f782d31"
        $s18 = "33cc5da72ac9d7bb"
        $s19 = "b1d71f4c2596cd55"
        $s20 = "101fb9d9e86d9e6c"
    
    condition:
        IIS_Native_Module and 1 of ($i*) and 3 of ($s*)
}

rule IIS_Group09 {

    meta:
        description = "Detects Group 9 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $i1 = "FliterSecurity.dll"
        $i2 = {56565656565656565656565656565656}
        $i3 = "app|hot|alp|svf|fkj|mry|poc|doc|20" xor
        $i4 = "yisouspider|yisou|soso|sogou|m.sogou|sogo|sogou|so.com|baidu|bing|360" xor
        $i5 = "baidu|m.baidu|soso|sogou|m.sogou|sogo|sogou|so.com|google|youdao" xor
        $i6 = "118|abc|1go|evk" xor

        $s1 = "AVCFuckHttpModuleFactory"
        $s2 = "X-Forward"
        $s3 = "fuck32.dat"
        $s4 = "fuck64.dat"
        $s5 = "&ipzz1="
        $s6 = "&ipzz2="
        $s7 = "&uuu="

        $s8 = "http://20.3323sf.c" xor
        $s9 = "http://bj.whtjz.c" xor
        $s10 = "http://bj2.wzrpx.c" xor
        $s11 = "http://cs.whtjz.c" xor
        $s12 = "http://df.e652.c" xor
        $s13 = "http://dfcp.yyphw.c" xor
        $s14 = "http://es.csdsx.c" xor
        $s15 = "http://hz.wzrpx.c" xor
        $s16 = "http://id.3323sf.c" xor
        $s17 = "http://qp.008php.c" xor
        $s18 = "http://qp.nmnsw.c" xor
        $s19 = "http://sc.300bt.c" xor
        $s20 = "http://sc.wzrpx.c" xor
        $s21 = "http://sf2223.c" xor
        $s22 = "http://sx.cmdxb.c" xor
        $s23 = "http://sz.ycfhx.c" xor
        $s24 = "http://xpq.0660sf.c" xor
        $s25 = "http://xsc.b1174.c" xor

    condition:
        IIS_Native_Module and any of ($i*) and 3 of ($s*)
}

rule IIS_Group10 {

    meta:
        description = "Detects Group 10 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $s1 = "IIS7.dll"
        $s2 = "<title>(.*?)title(.*?)>"
        $s3 = "<meta(.*?)name(.*?)=(.*?)keywords(.*?)>"
        $s4 = "<meta(.*?)name(.*?)=(.*?)description(.*?)>"
        $s5 = "js.breakavs.co"
        $s6 = "&#24494;&#20449;&#32676;&#45;&#36187;&#36710;&#80;&#75;&#49;&#48;&#32676;&#12304;&#36827;&#32676;&#24494;&#20449;&#102;&#117;&#110;&#53;&#55;&#54;&#52;&#52;&#12305;&#95;&#24184;&#36816;&#39134;&#33351;&#95;&#24184;&#36816;&#50;&#56;&#32676;"
        $s7 = "&#21271;&#20140;&#36187;&#36710;&#24494;&#20449;&#32676;&#44;&#21271;&#20140;&#24494;&#20449;&#36187;&#36710;&#32676;&#44;&#21271;&#20140;&#36187;&#36710;&#24494;&#20449;&#32676;&#44;&#80;&#75;&#49;&#48;&#32676;&#44;&#21271;&#20140;&#36187;&#36710;&#112;&#107;&#49;&#48;&#24494;&#20449;&#32676;&#44;&#80;&#75;&#49;&#48;&#24494;&#20449;&#32676;&#44;&#36187;&#36710;&#24494;&#20449;&#32676;&#44;&#21271;&#20140;&#36187;&#36710;&#32676;&#44;"
        $s8 = "&#21271;&#20140;&#36187;&#36710;&#24494;&#20449;&#32676;&#44;&#21271;&#20140;&#24494;&#20449;&#36187;&#36710;&#32676;&#12304;&#36827;&#32676;&#24494;&#20449;&#21495;&#102;&#117;&#110;&#53;&#55;&#54;&#52;&#52;&#12305;&#21271;&#20140;&#24494;&#20449;&#36187;&#36710;&#32676;&#44;&#21271;&#20140;&#24494;&#20449;&#36187;&#36710;"

        $e1 = "Baiduspider"
        $e2 = "Sosospider"
        $e3 = "Sogou web spider"
        $e4 = "360Spider"
        $e5 = "YisouSpider"
        $e6 = "sogou.com"
        $e7 = "soso.com"
        $e8 = "uc.cn"
        $e9 = "baidu.com"
        $e10 = "sm.cn"

    condition:
        IIS_Native_Module and 2 of ($e*) and 3 of ($s*)
}

rule IIS_Group11 {

    meta:
        description = "Detects Group 11 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $s1 = "DnsQuery_A"
        $s2 = "&reurl="
        $s3 = "&jump=1"

        // encrypted "HTTP_cmd" (SUB 2)
        $s4 = "JVVRaeof" 

        // encrypted "lanke88" (SUB 2)
        $s5 = "ncpmg::0"

        // encrypted "xinxx.allsoulu[.]com" (SUB 2)
        $s6 = "zkpzz0cnnuqwnw0eqo" 

        // encrypted "http://www.allsoulu[.]com/1.php?cmdout=" (SUB 2)
        $s7 = "jvvr<11yyy0cnnuqwnw0eqo130rjrAeofqwv?"

    condition:
        IIS_Native_Module and 3 of ($s*)
}

rule IIS_Group12 {

    meta:
        description = "Detects Group 12 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $s1 = "C:\\inetpub\\temp\\IIS Temporary Compressed Files\\"
        $s2 = "F5XFFHttpModule.dll"
        $s3 = "gtest_redir"
        $s4 = "\\cmd.exe" nocase
        $s5 = "iuuq;00" // encrypted "http://" (ADD 1)
        $s6 = "?xhost="
        $s7 = "&reurl="
        $s8 = "?jump=1"
        $s9 = "app|zqb"
        $s10 = "ifeng|ivc|sogou|so.com|baidu|google|youdao|yahoo|bing|118114|biso|gougou|sooule|360|sm|uc"
        $s11 = "sogou|so.com|baidu|google|youdao|yahoo|bing|gougou|sooule|360|sm.cn|uc"
        $s12 = "Hotcss/|Hotjs/"
        $s13 = "HotImg/|HotPic/"
        $s14 = "msf connect error !!"
        $s15 = "download ok !!"
        $s16 = "download error !! "
        $s17 = "param error !!"
        $s18 = "Real Path: "
        $s19 = "unknown cmd !"

        // hardcoded hash values
        $b1 = {15 BD 01 2E [-] 5E 40 08 97 [-] CF 8C BE 30 [-] 28 42 C6 3B}
        $b2 = {E1 0A DC 39 [-] 49 BA 59 AB [-] BE 56 E0 57 [-] F2 0F 88 3E}

    condition:
        IIS_Native_Module and 5 of them
}

rule IIS_Group13_IISerpent {

    meta:
        description = "Detects Group 13 native IIS malware family (IISerpent)"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $s1 = "/mconfig/lunlian.txt"
        $s2 = "http://sb.qrfy.ne"
        $s3 = "folderlinkpath"
        $s4 = "folderlinkcount"
        $s5 = "onlymobilespider"
        $s6 = "redirectreferer"
        $s7 = "loadSuccessfull : "
        $s8 = "spider"
        $s9 = "<a href="
        $s11 = "?ReloadModuleConfig=1"
        $s12 = "?DisplayModuleConfig=1"

    condition:
        IIS_Native_Module and 5 of them
}

rule IIS_Group14 {

    meta:
        description = "Detects Group 14 native IIS malware family"
        author = "ESET Research"
        date = "2021-08-04"
        reference = "https://www.welivesecurity.com/"
        source = "https://github.com/eset/malware-ioc/"
        license = "BSD 2-Clause"
        version = "1"

    strings: 
        $i1 = "agent-self: %s"
        $i2 = "/utf.php?key="
        $i3 = "/self.php?v="
        $i4 = "<script type=\"text/javascript\" src=\"//speed.wlaspsd.co"
        $i5 = "now.asmkpo.co"

        $s1 = "Baiduspider"
        $s2 = "360Spider"
        $s3 = "Sogou"
        $s4 = "YisouSpider"
        $s6 = "HTTP_X_FORWARDED_FOR"


    condition:
        IIS_Native_Module and 2 of ($i*) or 5 of them
}
