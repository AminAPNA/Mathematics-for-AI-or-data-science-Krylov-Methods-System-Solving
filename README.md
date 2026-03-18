#  Mathematics for AI (or data science), Krylov Methods & System Solving

This repository contains material for the first session of the **Mathematics for AI** course, focusing on **numerical linear algebra** and **Krylov subspace methods**, in particular the Arnoldi and Lanczos algorithms.

---

## Why Numerical Linear Algebra Matters

At the core of modern science, engineering, and artificial intelligence lies a fundamental computational task:

> **Solve linear systems of the form:** `Ax = b`

No matter how complex a model is, whether in machine learning, optimization, or scientific computing, it almost always reduces (explicitly or implicitly) to solving such systems either linear or nonlinear.

### Key reasons this field is essential:

- **Scalability** , real-world problems involve millions or billions of variables  
- **Efficiency** , direct methods quickly become too expensive  
- **Stability** , numerical errors must be controlled  
- **Structure awareness** , matrices are often sparse or structured  

---

##  From Problems to Linear Systems

Many important tasks reduce to linear systems:

### Optimization
- Gradient-based methods require linear solves or approximations  
- Newton-type methods explicitly solve systems with Hessians  

### Machine Learning
- Linear regression → normal equations  
- Kernel methods → large dense systems  
- Graph learning → Laplacian systems  

### Scientific Computing
- PDE discretization → large sparse systems  
- Simulations rely on repeated system solves  

**Conclusion:** Efficient linear system solving is foundational.

---

##  Why Krylov Subspace Methods?

For large-scale problems, **iterative methods** are preferred over direct solvers.

Krylov methods approximate the solution in the space:

    K_k(A, r0) = span{r0, Ar0, A^2 r0, ..., A^(k-1) r0}

Instead of solving the full system, they:

- Build progressively better approximations  
- Use only matrix-vector products  
- Avoid storing dense matrices  

---

##  Algorithms Covered

### Arnoldi Algorithm
- Builds an orthonormal basis of the Krylov subspace  
- Produces an upper Hessenberg matrix  
- Foundation of GMRES  

**Advantages:**
- Numerically stable  
- Works for general matrices  

---

### Lanczos Algorithm
- Specialized for symmetric matrices  
- Produces a tridiagonal matrix  
- Uses short recurrences  

**Advantages:**
- Faster and memory-efficient  
- Widely used in large-scale problems  

---

##  Relevance to AI & Data Science

Linear algebra is at the heart of modern AI:

### Model Training
- Least squares, ridge regression  
- Logistic regression via iterative solvers  

### Deep Learning
- Backpropagation uses repeated linear operations  
- Advanced methods require solving linear systems  

### Graph Methods
- PageRank, diffusion, embeddings  

### Dimensionality Reduction
- PCA and spectral methods  

---

##  Big Picture

> Most problems in AI and data science reduce to:
>
> **efficiently solving large linear systems**

Krylov methods provide:

- Scalability  
- Efficiency  
- Practical applicability  

---

##  Repository Contents

- Implementations of Arnoldi and Lanczos  
- Applications to linear system solving  
- Examples and experiments  
- Extensions (GMRES, MINRES, Conjugate Gradient)  

---

Numerical linear algebra is the **computational backbone of AI**.


---

Some **real-life examples** are provided in this [PDF document](https://github.com/AminAPNA/Mathematics-for-AI-or-data-science-Krylov-Methods-System-Solving/blob/main/Example_Projects.pdf), and the corresponding **MATLAB codes** are available [here](PUT_YOUR_MATLAB_LINK_HERE).
