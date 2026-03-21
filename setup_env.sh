#!/usr/bin/env bash
# Qiskit Classroom Environment Setup Script
# Requires: uv (https://docs.astral.sh/uv/getting-started/installation/)


PYTHON_VERSION="3.11"
VENV_DIR=".venv"

# ── 1. Check for uv ──────────────────────────────────────────────────────────
if ! command -v uv &> /dev/null; then
    echo "uv not found. Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Reload shell env so uv is available
    export PATH="$HOME/.local/bin:$PATH"
fi

# ── 2. Install Python 3.11 ───────────────────────────────────────────────────
echo "Installing Python $PYTHON_VERSION via uv..."
uv python install $PYTHON_VERSION

# ── 3. Create virtual environment ────────────────────────────────────────────
echo "Creating virtual environment at $VENV_DIR ..."
uv venv -p $PYTHON_VERSION "$VENV_DIR"

# ── 4. Activate venv ─────────────────────────────────────────────────────────
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

# ── 5. Install pip then packages ─────────────────────────────────────────────
echo "Installing pip..."
uv pip install pip

echo "Installing Qiskit packages..."
pip install \
    'qiskit>=2.1.0' \
    'qiskit-ibm-runtime>=0.40.1' \
    'qiskit-aer>=0.17.0' \
    'numpy' \
    'pylatexenc' \
    'jupyter' \
    'matplotlib'

# ── 6. Smoke test ─────────────────────────────────────────────────────────────
echo "Running smoke test..."
python scratch.py

echo ""
echo "Setup complete. Venv is active in this shell."
echo "To activate in a new session: source $VENV_DIR/bin/activate"
