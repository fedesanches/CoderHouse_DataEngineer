FROM python:3

RUN pip install pandas
RUN mkdir WORK_REPO
RUN cd WORK_REPO

WORKDIR /WORK_REPO

ADD script.py .

CMD ["python", "-u", "script.py"]