FROM frappe/erpnext:v15.121.3

USER frappe

# Pasang dependensi payments, hrms, dan lms branch version-15 secara permanen
RUN bench get-app payments --branch version-15 \
    && bench get-app https://github.com/kindiyanuar/hrms.git --branch version-15 \
    && bench get-app https://github.com/kindiyanuar/lms.git --branch version-15
