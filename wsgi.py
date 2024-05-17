from app import app

if __name__ == '__main__':
  print("server is running on port 8000")
  app.run(debug=True)