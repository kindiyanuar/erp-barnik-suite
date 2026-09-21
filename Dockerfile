FROM frappe/erpnext:v15.121.3

USER frappe

# Pasang modul HRMS secara permanen ke dalam image
RUN bench get-app https://github.com/kindiyanuar/hrms.git --branch version-15
