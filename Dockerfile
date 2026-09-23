FROM frappe/erpnext:version-16

USER frappe
WORKDIR /home/frappe/frappe-bench

# 1. Clone aplikasi (Gunakan repositori resmi untuk wiki dan payments, fork pribadi untuk hrms dan lms)
RUN git clone --depth 1 -b version-16 https://github.com/frappe/payments.git ./apps/payments \
    && git clone --depth 1 -b version-16 https://github.com/kindiyanuar/hrms.git ./apps/hrms \
    && git clone --depth 1 -b version-16 https://github.com/kindiyanuar/lms.git ./apps/lms \
    && git clone --depth 1 -b main https://github.com/frappe/wiki.git ./apps/wiki

# 2. Pasang package python langsung menggunakan pip milik virtualenv bench
RUN ./env/bin/pip install --no-cache-dir -e ./apps/payments \
    && ./env/bin/pip install --no-cache-dir -e ./apps/hrms \
    && ./env/bin/pip install --no-cache-dir -e ./apps/lms \
    && ./env/bin/pip install --no-cache-dir -e ./apps/wiki

# 3. Daftarkan aplikasi ke file apps.txt bawaan bench
RUN echo "payments" >> ./sites/apps.txt \
    && echo "hrms" >> ./sites/apps.txt \
    && echo "lms" >> ./sites/apps.txt \
    && echo "wiki" >> ./sites/apps.txt
