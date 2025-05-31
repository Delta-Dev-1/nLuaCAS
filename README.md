# [WIP] nLuaCAS - Symbolic Calculus Engine for TI-Nspire CX

**nLuaCAS** is a symbolic math engine built in Lua for TI-Nspire calculators. Designed for educational purposes, it enables symbolic differentiation, integration, simplification, and solving — all without requiring Ndless.
This is a WIP.
> ⚠️ This tool is meant for learning and exploration. Do not use during assessments unless explicitly allowed.

## ✨ Features

- **Symbolic Differentiation** — Basic, higher-order, partial, and chain rule support.
- **Symbolic Integration** — Indefinite and definite integrals with rules for polynomials and trig.
- **Simplification** — Combine like terms, expand binomials, reduce expressions.
- **Equation Solving** — Solve linear, quadratic, and some cubic equations symbolically.
- **Function Memory** — Define and reuse functions (e.g., `let f(x) = x^2 + 1`).
- **History + Help** — Tabs for prior computations and examples.
- **No Ndless Required** — Fully compatible with TI-Nspire CX II and CX.

## 🖥 How to Use

Transfer `nLuaCAS.tns` to your calculator using TI-Nspire Link Software or [nLink](https://github.com/ndless-nspire/nlink).

### Input Examples

| Action               | Example                    |
|----------------------|----------------------------|
| Derivative           | `d/dx(x^2)`                |
| Integral             | `int(x^2)` or `∫(x^2)dx`   |
| Definite Integral    | `int(x^2, 0, 1)`           |
| Solve Equation       | `solve(x^2 - 4 = 0)`       |
| Simplify Expression  | `simplify(x + x)`          |
| Function Definition  | `let f(x) = x^2 + 3`       |
| Function Evaluation  | `f(2)`                     |

Use `TAB` to switch views: Main ↔ History ↔ About ↔ Help.

## ✅ Compatibility

- ✅ Tested on **TI-Nspire CX II** (OS 6.2)
- ✅ Compatible with **TI-Nspire CX** (may have minor UI limitations)
- ❌ Not for monochrome models
- ❌ Does not require Ndless or OS modification

---

## 🔐 Legal & License

This is a **community-made** educational tool and is **not affiliated with or endorsed by Texas Instruments**.

### License & Attribution

- **CAS engine (core logic)**:  
  © 2024 DeltaDev, released under the MIT License.
- **User interface & UI layout**:  
  Derived from **SuperSpire (S²)** by Xavier Andréani (https://tipla.net/a29172),  
  used under Creative Commons Attribution-ShareAlike 2.0 (CC BY-SA 2.0 FR).  
  UI modifications and integration by DeltaDev.

If you reuse/adapt the UI code, you must preserve the same attribution and license terms.

**No TI firmware, OS files, or proprietary assets are included.**

---

## 🙏 Credits

- **CAS engine, integration, & documentation:**  
  [@DeltaDev](https://github.com/yourusername)
- **Original UI framework:**  
  SuperSpire (S²) by Xavier Andréani — [tipla.net/a29172](https://tipla.net/a29172)
- Thanks to the open calculator development community ❤️

---

*This is a derivative work of SuperSpire (S²), with substantial original code for the symbolic engine by DeltaDev.*