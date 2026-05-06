<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Student Details Form</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background: linear-gradient(135deg, #e0f7fa, #f1f8ff);
      min-height: 100vh;
      overflow-x: hidden;
    }

    .container {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .top-section {
      height: 80vh;
      padding: 30px;
      display: flex;
      gap: 30px;
    }

    .form-section,
    .display-section {
      flex: 1;
      background: white;
      border-radius: 20px;
      padding: 25px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    h1 {
      color: #1e3a8a;
      margin-bottom: 25px;
      text-align: center;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      color: #374151;
    }

    input,
    select {
      width: 100%;
      padding: 12px;
      border: 2px solid #d1d5db;
      border-radius: 10px;
      font-size: 16px;
      transition: border-color 0.3s ease;
    }

    input:focus,
    select:focus {
      outline: none;
      border-color: #2563eb;
    }

    button {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 18px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    button:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
    }

    .student-list {
      margin-top: 20px;
      max-height: 500px;
      overflow-y: auto;
    }

    .student-header,
    .student-row {
      display: grid;
      grid-template-columns: 1fr 1fr 1.5fr;
      gap: 15px;
      padding: 12px;
      border-bottom: 1px solid #e5e7eb;
      align-items: center;
    }

    .student-header {
      background: #eff6ff;
      font-weight: bold;
      color: #1e40af;
      border-radius: 10px;
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .student-row:nth-child(even) {
      background: #f9fafb;
    }

    .student-row:hover {
      background: #eef4ff;
    }

    .animation-section {
      height: 20vh;
      background: linear-gradient(to top, #bbf7d0, #dcfce7);
      position: relative;
      overflow: hidden;
      border-top: 3px solid #86efac;
    }

    .ground {
      position: absolute;
      bottom: 0;
      width: 100%;
      height: 40px;
      background: #22c55e;
    }

    .student-cartoon {
      position: absolute;
      bottom: 40px;
      left: -220px;
      width: 260px;
      height: 160px;
      animation: studyJourney 20s linear infinite;
    }

    .character {
      position: absolute;
      left: 20px;
      bottom: 0;
      transform-origin: bottom center;
      animation: sitAndStudy 20s ease-in-out infinite;
    }

    .character::before,
    .character::after {
      content: '';
      position: absolute;
      width: 8px;
      height: 45px;
      background: #1f2937;
      bottom: -35px;
      border-radius: 10px;
      transform-origin: top center;
    }

    .character::before {
      left: 18px;
      animation: legMove1 20s infinite;
    }

    .character::after {
      left: 48px;
      animation: legMove2 20s infinite;
    }

    .head {
      width: 40px;
      height: 40px;
      background: #fbbf24;
      border-radius: 50%;
      margin-left: 20px;
    }

    .body {
      width: 80px;
      height: 70px;
      background: #3b82f6;
      border-radius: 20px;
      margin-top: -5px;
    }

    .book {
      position: absolute;
      width: 70px;
      height: 45px;
      background: linear-gradient(90deg, #dc2626 50%, #f87171 50%);
      left: 110px;
      bottom: 25px;
      border-radius: 6px;
      transform-origin: left center;
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
      animation: openBook 20s infinite;
    }

    .laptop {
      position: absolute;
      width: 80px;
      height: 50px;
      background: #4b5563;
      left: 145px;
      bottom: 15px;
      border-radius: 6px;
      opacity: 0;
      transform-origin: bottom left;
      animation: useLaptop 20s infinite;
    }

    .laptop::before {
      content: '';
      position: absolute;
      width: 75px;
      height: 8px;
      background: #4b5563;
      bottom: -8px;
      left: -2px;
      border-radius: 3px;
    }

    .empty-message {
      text-align: center;
      color: #6b7280;
      margin-top: 50px;
      font-size: 18px;
    }

    .error-message,
    .success-message {
      margin-top: 15px;
      padding: 12px;
      border-radius: 8px;
      display: none;
    }

    .error-message {
      background: #fee2e2;
      color: #b91c1c;
    }

    .success-message {
      background: #dcfce7;
      color: #166534;
    }

    @keyframes studyJourney {
      0% { left: -220px; }
      15% { left: 10%; }
      25% { left: 18%; }
      75% { left: 18%; }
      85% { left: 25%; }
      100% { left: 110%; }
    }

    @keyframes sitAndStudy {
      0%, 15%, 85%, 100% { transform: translateY(0) rotate(0deg); }
      25%, 75% { transform: translateY(8px) rotate(-8deg); }
    }

    @keyframes legMove1 {
      0%, 15%, 85%, 100% { transform: rotate(12deg); }
      25%, 75% { transform: rotate(70deg); }
    }

    @keyframes legMove2 {
      0%, 15%, 85%, 100% { transform: rotate(-12deg); }
      25%, 75% { transform: rotate(90deg); }
    }

    @keyframes openBook {
      0%, 20% { transform: rotateY(0deg); }
      25%, 80% { transform: rotateY(-45deg); }
      85%, 100% { transform: rotateY(0deg); }
    }

    @keyframes useLaptop {
      0%, 20% { opacity: 0; }
      25%, 80% { opacity: 1; }
      85%, 100% { opacity: 0; }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="top-section">
      <div class="form-section">
        <h1> Student Details </h1>
        <form id="studentForm">
          <div class="form-group">
            <label for="name"> Name </label>
            <input type="text" id="name" placeholder="Enter student name" required>
          </div>

          <div class="form-group">
            <label for="course"> Course </label>
            <select id="course">
              <option value=""> Select Course </option>
              <option> Multi Cloud </option>
              <option> Azure Cloud </option>
              <option> AWS Cloud </option>
              <option> Python </option>
              <option> Java </option>
              <option> Others </option>
            </select>
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" placeholder="Enter email address">
          </div>

          <button type="submit">Add Student</button>
          <div id="successMessage" class="success-message"></div>
          <div id="errorMessage" class="error-message"></div>
        </form>
      </div>

      <div class="display-section">
        <h1>Student Records</h1>
        <div class="student-list">
          <div class="student-header">
            <div>Name</div>
            <div>Course</div>
            <div>Email</div>
          </div>
          <div id="studentData">
            <div class="empty-message">No student records added yet.</div>
          </div>
        </div>
      </div>
    </div>

    <div class="animation-section">
      <div class="student-cartoon">
        <div class="character">
          <div class="head"></div>
          <div class="body"></div>
        </div>
        <div class="book"></div>
        <div class="laptop"></div>
      </div>
      <div class="ground"></div>
    </div>
  </div>

<script>
  const API_BASE_URL = window.location.origin;

  const form = document.getElementById('studentForm');
  const studentData = document.getElementById('studentData');
  let students = [];

  async function loadStudents() {
    try {
      const response = await fetch(API_BASE_URL + "/students");

      if (!response.ok) {
        throw new Error("Server returned " + response.status);
      }

      students = await response.json();
      renderStudents();

    } catch (error) {
      console.error("Error loading students:", error);

      studentData.innerHTML = `
        <div class="empty-message">
          Unable to connect to Flask API on VM (${vm_ip})
        </div>
      `;
    }
  }

  form.addEventListener('submit', async function (e) {
    e.preventDefault();

    const name = document.getElementById('name').value.trim();
    const course = document.getElementById('course').value.trim();
    const email = document.getElementById('email').value.trim();

    try {
      const response = await fetch(API_BASE_URL + "/students", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ name, course, email })
      });

      const result = await response.json();

      if (!response.ok) {
        alert(result.error || "Failed to add student");
        return;
      }

      await loadStudents();
      form.reset();

    } catch (error) {
      console.error("Error adding student:", error);
      alert("Unable to connect to Flask API on EC2");
    }
  });

  function renderStudents() {
    if (!students || students.length === 0) {
      studentData.innerHTML =
        '<div class="empty-message">No student records found in database.</div>';
      return;
    }

    studentData.innerHTML = students.map(student => `
      <div class="student-row">
        <div>$${student.name || "NA"}</div>
        <div>$${student.course || "NA"}</div>
        <div>$${student.email || "NA"}</div>
      </div>
    `).join('');
  }

  window.addEventListener('DOMContentLoaded', loadStudents);
</script>

</body>
</html>
