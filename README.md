# Flutter Experiment 7 – Application State Management and Serialization

**Course Code**: 24CS2016  
**Project Name**: `state_app`  
**Expected Result**: A Flutter application that models structured student data, converts data between Dart objects and JSON (`toJson()` & `fromJson()`), and dynamically updates UI list state using `setState()`.

---

## 📌 Project Overview & Structure

This project implements all steps from Experiment 7 in the lab manual:

- **Step 2 – Student Model (`lib/student.dart`)**: Data class with constructor, `toJson()` serializer, and `Student.fromJson()` factory constructor.
- **Step 3 – Instantiate Object**: `Student student = Student(id: 1, name: 'Raj', course: 'CSE');`
- **Step 4 – Object to JSON**: Converts `student.toJson()` to Map / JSON string.
- **Step 5 – JSON to Object**: Reconstructs `Student.fromJson(data)` back into a Dart instance.
- **Step 6 – State List Management**: Maintains `List<Student> students = []` updated via `setState()`.
- **Step 7 – Dynamic Display**: Renders list items using `ListView.builder`.

---

## 🚀 How to Deploy to a New GitHub Repository

### Step 1: Create a New Repository on GitHub
Create a new repository named `flutter_exp_7` on GitHub.

### Step 2: Push Code using `deploy.sh`
Run inside `/home/frost/git/state_app`:
```bash
./deploy.sh
```
When prompted, enter your repository URL:
```text
https://github.com/YOUR_USERNAME/flutter_exp_7.git
```

### Step 3: Enable GitHub Pages
1. Go to repository **Settings ➔ Pages**.
2. Set **Source** to `Deploy from a branch`.
3. Select **`gh-pages`** branch and `/ (root)`.
4. Click **Save**.

Your live app will be published at:  
`https://YOUR_USERNAME.github.io/flutter_exp_7/`
