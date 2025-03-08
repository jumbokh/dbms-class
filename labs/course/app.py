from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        action = request.form.get('action')
        if action == 'greet':
            return redirect(url_for('greet'))
        elif action == 'info':
            return redirect(url_for('info'))
        elif action == 'contact':
            return redirect(url_for('contact'))
    return render_template('index.html')

@app.route('/greet')
def greet():
    return "Hello! Welcome to our website."

@app.route('/info')
def info():
    return "This is the information page. Here you can find more details about us."

@app.route('/contact')
def contact():
    return "Contact us at: example@example.com"

if __name__ == '__main__':
    app.run(debug=True)
