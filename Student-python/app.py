from flask import Flask, request, jsonify, render_template, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from config import Config

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

# ─────────────────────────────
# MODEL
# ─────────────────────────────
class Student(db.Model):
    __tablename__ = 'students'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    course = db.Column(db.String(100), default='General')

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "course": self.course
        }


# ─────────────────────────────
# HOME (HTML PAGE - GET ALL)
# ─────────────────────────────
@app.route('/', methods=['GET'])
def home():
    students = Student.query.all()
    return render_template("index.html", students=students)


# ─────────────────────────────
# API: GET ALL STUDENTS
# ─────────────────────────────
@app.route('/students', methods=['GET'])
def api_get_all_students():
    students = Student.query.all()
    return jsonify([s.to_dict() for s in students])


# ─────────────────────────────
# API: GET STUDENT BY ID
# ─────────────────────────────
@app.route('/students/<int:id>', methods=['GET'])
def api_get_student_by_id(id):
    student = Student.query.get_or_404(id)
    return jsonify(student.to_dict())


# ─────────────────────────────
# HTML FORM: ADD STUDENT
# ─────────────────────────────
@app.route('/add', methods=['POST'])
def add_student_form():
    name = request.form.get('name')
    email = request.form.get('email')
    course = request.form.get('course')

    if not name or not email:
        return "Name and Email required", 400

    existing = Student.query.filter_by(email=email).first()
    if existing:
        return "Email already exists", 400

    student = Student(name=name, email=email, course=course)
    db.session.add(student)
    db.session.commit()

    return redirect(url_for('home'))


# ─────────────────────────────
# API: ADD STUDENT (JSON)
# ─────────────────────────────
@app.route('/students', methods=['POST'])
def api_add_student():
    data = request.get_json()

    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    name = data.get("name")
    email = data.get("email")
    course = data.get("course", "General")

    if not name or not email:
        return jsonify({"error": "name and email required"}), 400

    try:
        student = Student(name=name, email=email, course=course)
        db.session.add(student)
        db.session.commit()
        return jsonify(student.to_dict()), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 400


# ─────────────────────────────
# API: DELETE STUDENT BY ID
# ─────────────────────────────
@app.route('/students/<int:id>', methods=['DELETE'])
def api_delete_student(id):
    student = Student.query.get_or_404(id)

    db.session.delete(student)
    db.session.commit()

    return jsonify({"message": "Deleted successfully"})


# ─────────────────────────────
# RUN APP
# ─────────────────────────────
if __name__ == '__main__':
    with app.app_context():
        db.create_all()

    app.run(host='0.0.0.0', port=5000, debug=True)