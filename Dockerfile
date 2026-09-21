FROM frappe/erpnext:v15.121.3

USER frappe
WORKDIR /home/frappe/frappe-bench

# Unduh aplikasi tanpa memicu asset build otomatis
RUN bench get-app payments --branch version-15 \
    && bench get-app https://github.com/kindiyanuar/hrms.git --branch version-15 \
    && bench get-app https://github.com/kindiyanuar/lms.git --branch version-15

# Pasang package python ke environment bench
RUN uv pip install --no-cache-dir -e ./apps/payments \
    && uv pip install --no-cache-dir -e ./apps/hrms \
    && uv pip install --no-cache-dir -e ./apps/lms
