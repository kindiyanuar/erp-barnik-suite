FROM frappe/erpnext:version-16

USER frappe
WORKDIR /home/frappe/frappe-bench

# 1. Clone aplikasi branch version-16 dan develop (khusus untuk wiki) secara langsung via git
RUN git clone --depth 1 -b version-16 https://github.com/frappe/payments.git ./apps/payments \
    && git clone --depth 1 -b version-16 https://github.com/kindiyanuar/hrms.git ./apps/hrms \
    && git clone --depth 1 -b version-16 https://github.com/kindiyanuar/lms.git ./apps/lms \
    && git clone --depth 1 -b develop https://github.com/frappe/wiki.git ./apps/wiki

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
