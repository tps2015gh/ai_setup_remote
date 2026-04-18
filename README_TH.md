# ระบบ LAN Remote CLI (Windows & Mobile)

โปรเจกต์นี้จัดทำชุดสคริปต์เพื่อตั้งค่าสภาพแวดล้อม CLI สำหรับการควบคุมระยะไกลผ่านเครือข่ายภายในบ้าน (LAN) โดยช่วยให้อุปกรณ์มือถือ (Android/Termux) สามารถเชื่อมต่อกับโน้ตบุ๊ก Windows 11 Home ผ่าน SSH เพื่อสื่อสารกับ AI Agent CLI ได้อย่างสะดวก

## ทีมพัฒนา (Team Dev)
- **Human (Director):** ผู้กำหนดวิสัยทัศน์ ความต้องการ และควบคุมทิศทางการพัฒนาทั้งหมด
- **Gemini CLI (Agent):** Senior AI Software Engineer และ **Interactive CLI Agent**; รับผิดชอบการเขียนสคริปต์ การตั้งค่าระบบ และการปรับแต่งสภาพแวดล้อมการทำงานระยะไกลเพื่อรองรับ AI Workflow
- **Security & Compliance Agent:** Strategic Auditor; รับผิดชอบการตรวจสอบช่องโหว่ (Bugs), การปฏิบัติตามกฎหมาย (Law), การรักษาความเป็นส่วนตัว (Privacy), ตรวจสอบความปลอดภัย และดูแลประสบการณ์การใช้งาน (UX) และลำดับขั้นตอนของโปรแกรม (Program Flow)

## เมนูหลัก (Master Menus)
เพื่อความสะดวกในการติดตั้ง สามารถใช้สคริปต์เมนูหลักที่อยู่ในโฟลเดอร์ราก (Root):

- **Windows:** รัน `.\menu.ps1` ใน PowerShell (โหมด Administrator)
- **Mobile/Linux:** รัน `./menu.sh` ใน Bash (Termux)

## โครงสร้างโปรเจกต์
- `windows_tmux/notebook/`: สคริปต์ตั้งค่าสำหรับเครื่อง Windows 11 (เครื่องแม่ข่าย)
- `windows_tmux/mobile/`: สคริปต์ตั้งค่าสำหรับเครื่อง Android (Termux) (เครื่องลูกข่าย)

## ขั้นตอนที่ 0: ดาวน์โหลดโปรเจกต์จาก GitHub (Clone)
เปิด Terminal (PowerShell ใน Windows หรือ Termux ใน Android) และรันคำสั่ง:
```bash
git clone https://github.com/tps2015gh/ai_setup_remote.git
cd ai_setup_remote
```

## ขั้นตอนการติดตั้งอย่างรวดเร็ว

### 1. สำหรับโน้ตบุ๊ก (Windows 11 Home)
- เปิด **PowerShell** ในโหมด **Administrator**
- ไปยังโฟลเดอร์โปรเจกต์แล้วรัน `.\menu.ps1`
- เลือกข้อ 1 เพื่อติดตั้ง OpenSSH Server
- **จดจำหมายเลข IP Address** ที่แสดงตอนท้ายสคริปต์

### 2. สำหรับมือถือ (Android / Termux)
- **วิธีที่ 1 (ก๊อปปี้ไปวาง - ไม่ต้องโหลดโปรเจกต์):**
  ก๊อปปี้คำสั่งนี้ไปวางใน Termux:
  ```bash
  pkg install curl -y && curl -LO https://raw.githubusercontent.com/tps2015gh/ai_setup_remote/master/windows_tmux/mobile/setup_mobile.sh && chmod +x setup_mobile.sh && ./setup_mobile.sh
  ```
- **วิธีที่ 2 (แบบปกติ):**
  ไปที่โฟลเดอร์โปรเจกต์แล้วรัน `./menu.sh` หรือ `./setup_mobile.sh`

## การตรวจสอบความปลอดภัยและข้อกฎหมาย
สามารถอ่านรายละเอียดการตรวจสอบระบบทั้งหมดได้ที่ [AGENT_REVIEW.md](AGENT_REVIEW.md) (ภาษาอังกฤษ) เพื่อดูการวิเคราะห์ด้านความเป็นส่วนตัวและจุดบกพร่องที่ได้รับการแก้ไขแล้ว

## สิทธิ์การใช้งาน (License)
โปรเจกต์นี้ใช้สิทธิ์การใช้งานแบบ MIT License ดูรายละเอียดได้ที่ไฟล์ [LICENSE](LICENSE)
