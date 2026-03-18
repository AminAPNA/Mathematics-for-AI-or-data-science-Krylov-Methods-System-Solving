# 📘 Mathematics for AI (data science), Krylov Methods & System Solving

This repository contains material for the first session of the **Mathematics for AI** course, focusing on **numerical linear algebra** and, in particular, **Krylov subspace methods** such as the Arnoldi and Lanczos algorithms.

---

##  Why Numerical Linear Algebra Matters

At the core of modern science, engineering, and artificial intelligence lies a fundamental computational task:

> **Solving linear systems of the form**  
> `Ax = b`

No matter how complex a model appears—whether in machine learning, physics, or optimization—it almost always reduces (explicitly or implicitly) to solving such systems.

### Key reasons numerical linear algebra is essential:

- **Scalability:** Real-world problems involve millions or billions of variables  
- **Efficiency:** Direct methods (e.g., Gaussian elimination) are often too expensive  
- **Stability:** Numerical errors must be controlled carefully  
- **Structure exploitation:** Many matrices are sparse, symmetric, or low-rank  

---

## 🔁 From Problems to Linear Systems

Many important tasks reduce to linear algebraic systems:

### In optimization
- Gradient-based methods require solving linear systems or approximations  
- Second-order methods (Newton-type) explicitly solve systems involving Hessians  

### In machine learning
- Linear regression → normal equations  
- Kernel methods → large dense systems  
- Graph-based learning → Laplacian systems  

### In scientific computing
- Discretizing differential equations → large sparse linear systems  
- Simulation pipelines rely heavily on repeated system solves  

👉 **Conclusion:** Efficient system solving is not optional—it is foundational.

---

## ⚡ Why Krylov Subspace Methods?

For large-scale problems, especially with sparse matrices, **iterative methods** are preferred over direct solvers.

Krylov methods build approximate solutions in the space:
