import tkinter as tk
from tkinter import filedialog
import numpy as np

class SLAEApp:
    def __init__(self, master):
        self.master = master
        master.title("SLAE Solver")

        self.label_method = tk.Label(master, text="Select method:")
        self.label_method.pack()

        self.method_var = tk.StringVar(master)
        self.method_var.set("Cramer's Method")  # Default method
        self.method_menu = tk.OptionMenu(master, self.method_var, "Cramer's Method", "Gauss Method", "Seidel Method", "Gauss-Jordan Method", "Jacobi Method")
        self.method_menu.pack()

        self.label_matrix = tk.Label(master, text="Enter matrix and vector:")
        self.label_matrix.pack()

        self.matrix_text = tk.Text(master, height=10, width=30)
        self.matrix_text.pack()

        self.button_file = tk.Button(master, text="Load from File", command=self.load_from_file)
        self.button_file.pack()

        self.button_solve = tk.Button(master, text="Solve", command=self.solve)
        self.button_solve.pack()

    def load_from_file(self):
        filename = filedialog.askopenfilename()
        if filename:
            try:
                with open(filename, 'r') as file:
                    data = file.read()
                    self.matrix_text.delete("1.0", tk.END)
                    self.matrix_text.insert("1.0", data)
            except Exception as e:
                print("Error loading file:", e)


    def solve(self):
        method = self.method_var.get()
        if hasattr(self, 'n') and self.n > 4:
            print("Number of equations exceeds 4. Cramer's method cannot be applied.")
            return
        if method == "Cramer's Method":
            self.solve_with_cramers_method()
        elif method == "Gauss Method":
            self.solve_with_gauss_method()
        elif method == "Seidel Method":
            self.solve_with_seidel_method()
        elif method == "Gauss-Jordan Method":
            self.solve_with_gauss_jordan_method()
        elif method == "Jacobi Method":
            self.solve_with_jacobi_method()
        else:
            print("Invalid method selected")
            
            
    def solve_with_cramers_method(self):
        try:
            matrix_text = self.matrix_text.get("1.0", tk.END)
            lines = matrix_text.split("\n")
            n = int(lines[0])
            A = np.array([list(map(float, line.split())) for line in lines[1:]])
            self.n = n
            self.A = A[:,:-1]  # Extracting matrix A
            self.B = A[:,-1]    # Extracting vector B

            # Check if Cramer's method can be applied
            if n != self.A.shape[0]:
                print("Number of equations does not match the size of the coefficient matrix.")
                return

            # Solve using Cramer's method
            x = np.zeros(n)
            det_A = np.linalg.det(self.A)
            if det_A == 0:
                print("Determinant of A is zero. Cramer's method cannot be applied.")
                return
            for i in range(n):
                Ai = self.A.copy()
                Ai[:,i] = self.B
                x[i] = np.linalg.det(Ai) / det_A
            print("Solution using Cramer's Method:")
            print(x)
        except Exception as e:
            print("Error:", e)

    def solve_with_gauss_method(self):
        try:
            matrix_text = self.matrix_text.get("1.0", tk.END)
            lines = matrix_text.split("\n")
            n = int(lines[0])
            A = np.array([list(map(float, line.split())) for line in lines[1:]])
            self.n = n
            self.A = A[:,:-1]  # Extracting matrix A
            self.B = A[:,-1]    # Extracting vector B

            # Check if dimensions are valid
            if n != self.A.shape[0]:
                print("Number of equations does not match the size of the coefficient matrix.")
                return

            # Solve using Gauss method
            x = np.linalg.solve(self.A, self.B)
            print("Solution using Gauss Method:")
            print(x)
        except Exception as e:
            print("Error:", e)

    def solve_with_seidel_method(self):
        try:
            matrix_text = self.matrix_text.get("1.0", tk.END)
            lines = matrix_text.split("\n")
            n = int(lines[0])
            A = np.array([list(map(float, line.split())) for line in lines[1:]])
            self.n = n
            self.A = A[:,:-1]  # Extracting matrix A
            self.B = A[:,-1]    # Extracting vector B

            # Check if dimensions are valid
            if n != self.A.shape[0]:
                print("Number of equations does not match the size of the coefficient matrix.")
                return

            # Solve using Seidel method
            x = np.zeros(n)
            max_iterations = 100
            tol = 1e-6
            for _ in range(max_iterations):
                x_old = np.copy(x)
                for i in range(n):
                    sum_ = np.dot(self.A[i, :], x)
                    x[i] = (self.B[i] - sum_ + self.A[i, i] * x[i]) / self.A[i, i]
                if np.linalg.norm(x - x_old) < tol:
                    break
            print("Solution using Seidel Method:")
            print(x)
        except Exception as e:
            print("Error:", e)

    def solve_with_gauss_jordan_method(self):
        try:
            matrix_text = self.matrix_text.get("1.0", tk.END)
            lines = matrix_text.split("\n")
            n = int(lines[0])
            A = np.array([list(map(float, line.split())) for line in lines[1:]])
            self.n = n
            self.A = A[:,:-1]  # Extracting matrix A
            self.B = A[:,-1]    # Extracting vector B

            # Check if dimensions are valid
            if n != self.A.shape[0]:
                print("Number of equations does not match the size of the coefficient matrix.")
                return

            # Solve using Gauss-Jordan method
            aug_matrix = np.hstack((self.A, np.expand_dims(self.B, axis=1)))
            n = len(aug_matrix)
            for i in range(n):
                divisor = aug_matrix[i][i]
                aug_matrix[i] /= divisor
                for j in range(n):
                    if j != i:
                        multiplier = aug_matrix[j][i]
                        aug_matrix[j] -= multiplier * aug_matrix[i]
            x = aug_matrix[:, -1]
            print("Solution using Gauss-Jordan Method:")
            print(x)
        except Exception as e:
            print("Error:", e)

    def solve_with_jacobi_method(self):
        try:
            matrix_text = self.matrix_text.get("1.0", tk.END)
            lines = matrix_text.split("\n")
            n = int(lines[0])
            A = np.array([list(map(float, line.split())) for line in lines[1:]])
            self.n = n
            self.A = A[:,:-1]  # Extracting matrix A
            self.B = A[:,-1]    # Extracting vector B

            # Check if dimensions are valid
            if n != self.A.shape[0]:
                print("Number of equations does not match the size of the coefficient matrix.")
                return

            # Solve using Jacobi method
            x = np.zeros(n)
            max_iterations = 100
            tol = 1e-6
            for _ in range(max_iterations):
                x_new = np.zeros(n)
                for i in range(n):
                    x_new[i] = (self.B[i] - np.dot(self.A[i,:], x) + self.A[i,i] * x[i]) / self.A[i,i]
                if np.allclose(x, x_new, atol=tol):
                    break
                x = x_new
            print("Solution using Jacobi Method:")
            print(x)
        except Exception as e:
            print("Error:", e)


root = tk.Tk()
app = SLAEApp(root)
root.mainloop()
