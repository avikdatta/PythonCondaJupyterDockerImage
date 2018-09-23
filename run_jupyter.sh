. /home/vmuser/.bashrc

export PATH=$PATH:/home/vmuser/miniconda3/bin/

jupyter lab \
--ip=0.0.0.0 \
--port=8888 \
--no-browser \
--NotebookApp.iopub_data_rate_limit=100000000
