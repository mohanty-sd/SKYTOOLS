# SKYTOOLS
Codes for statistical analysis of data on the sphere.

- [pyenv_requirements.txt](pyenv_requirements.txt) Python virtual environment requirements. Create an empty virtual environment and use this file to recreate the environment for running the Python codes below. (See  for instructions [below](#python-virtual-environment) for creating a virtual environment.)
- [genNsidePix.py](genNsidePix.py) Use this Python code to generate a [HEALPix](https://healpix.sourceforge.io/html/intro_Introduction_HEALPix.htm) sky grid. The number of pixels in the grid
is derived from the ```nSide``` parameter (must be a power of 2). The output is an ascii file containing the polar and azimuthal coordinates of the pixels. Use the standard Python help command to get usage instructions for this script.
- [skyscatter2errarea.m](skyscatter2errarea.m) Matlab function that takes a set of points on the sky, estimates their probability density function, and computes the areas of regions with specified probabilities. Use the standard Matlab help command to get usage instructions for this function. This function implements the following steps:
    - Computes a kernel density estimate (KDE) of PDF of the input sky positions on a HEALPix grid.
    - Sorts the PDF values in descending order and computes their cumulative sum to map out error regions on the sky that enclose the desired probabilities.
    - Calculates the areas of these error regions in steradians.
    - Optionally returns the PDF values on a grid, the PDF contour levels corresponding to the error regions above, and the X and Y grids for plotting contours.
- [test_skyscatter2errarea.m](test_skyscatter2errarea.m) Matlab test script for [skyscatter2errarea.m](skyscatter2errarea.m).

# Python virtual environment
To use a `requirements.txt` file to create a new Python virtual environment with all necessary packages installed, follow these steps:

---

## **Step-by-Step Instructions**

**1. Navigate to your project directory:**
```bash
cd /path/to/your/project
```

**2. Create a new virtual environment:**
```bash
python -m venv venv
```
- Replace `venv` with your preferred environment name.

**3. Activate the virtual environment:**
- On **Linux/macOS**:
  ```bash
  source venv/bin/activate
  ```
- On **Windows**:
  ```bash
  venv\Scripts\activate
  ```

**4. Install all dependencies from `requirements.txt`:**
```bash
pip install -r requirements.txt
```
This command reads the `requirements.txt` file and installs all listed packages into your virtual environment[1][5][6].

---

## **Summary Table**

| Step         | Command (Linux/macOS)         | Command (Windows)           |
|--------------|------------------------------|-----------------------------|
| Create venv  | `python -m venv venv`        | `python -m venv venv`       |
| Activate venv| `source venv/bin/activate`   | `venv\Scripts\activate`     |
| Install reqs | `pip install -r requirements.txt` | `pip install -r requirements.txt` |

---

**In summary:**  
1. Create and activate a virtual environment.
2. Run `pip install -r requirements.txt` to install all required packages into the environment[1][5][6].

[1] https://stackoverflow.com/questions/41427500/creating-a-virtualenv-with-preinstalled-packages-as-in-requirements-txt
[2] https://www.reddit.com/r/PythonLearning/comments/1d57qpu/where_to_make_requirementstxt_for_virtual/
[3] https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/
[4] https://openclassrooms.com/en/courses/6900846-set-up-a-python-environment/6990546-manage-virtual-environments-using-requirements-files
[5] https://www.youtube.com/watch?v=1Y8SalXKtnI
[6] https://www.restack.io/p/nlp-immersive-virtual-environments-answer-create-virtual-environment-from-requirements-txt-cat-ai
[7] https://www.youtube.com/watch?v=h8bt4RvE7zM
[8] https://www.codewithharry.com/videos/python-tutorials-for-absolute-beginners-43/