FROM frappe/erpnext:version-16

USER root
RUN apt-get update && apt-get install -y pkg-config git

USER frappe
WORKDIR /home/frappe/frappe-bench

# Clone hanya aplikasi yang diperlukan
RUN git clone --depth 1 -b version-16 https://github.com/frappe/payments.git ./apps/payments \
    && git clone --depth 1 -b version-16 https://github.com/kindiyanuar/hrms.git ./apps/hrms

# Instal dependensi Python
RUN ./env/bin/pip install --no-cache-dir -e ./apps/payments \
    && ./env/bin/pip install --no-cache-dir -e ./apps/hrms

# Daftarkan ke apps.txt
RUN echo "payments" >> ./sites/apps.txt \
    && echo "hrms" >> ./sites/apps.txt
