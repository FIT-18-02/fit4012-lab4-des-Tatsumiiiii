# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Mục tiêu của bài lab là hiểu và triển khai thuật toán mã hóa DES cũng như mở rộng sang TripleDES ở mức cơ bản. 
Sinh viên cần nắm được cách hoạt động của các bước trong DES như hoán vị ban đầu (IP), chia block, hàm Feistel, sinh khóa vòng (round keys) và hoán vị cuối (IP-1). 
Ngoài ra, bài lab còn yêu cầu xử lý dữ liệu nhiều block, áp dụng zero padding và thực hiện mã hóa/giải mã đúng theo chuẩn nhập/xuất để phục vụ kiểm thử tự động (CI).

## Cách làm / Method

Chương trình được xây dựng từ file des.cpp với cấu trúc gồm các thành phần chính:

- Các hàm hỗ trợ: chuyển đổi nhị phân – thập phân, XOR.
- Khối hoán vị: initial permutation và inverse permutation.
- Lớp KeyGenerator: sinh 16 round keys từ key 64-bit theo chuẩn DES.
- Lớp DES: triển khai thuật toán DES với 16 vòng Feistel, bao gồm expansion, substitution (S-box) và permutation.

Chương trình hỗ trợ 4 chế độ:
1. DES encrypt
2. DES decrypt
3. TripleDES encrypt
4. TripleDES decrypt

Đối với DES:
- Dữ liệu đầu vào được chia thành các block 64-bit.
- Nếu block cuối không đủ 64-bit thì áp dụng zero padding.

Đối với TripleDES:
- Áp dụng mô hình EDE: E(K1) → D(K2) → E(K3) khi mã hóa.
- Giải mã theo thứ tự ngược lại.

Chương trình nhận dữ liệu từ stdin theo đúng format yêu cầu của đề bài để đảm bảo tương thích với hệ thống CI.

## Kết quả / Result

Chương trình đã chạy đúng với các test cơ bản:

- Test mã hóa/giải mã:
  + Khi mã hóa một plaintext và sau đó giải mã với cùng key, kết quả thu được trùng với plaintext ban đầu (round-trip thành công).

- Test multi-block:
  + Khi nhập chuỗi dài hơn 64 bit, chương trình tự động chia block và xử lý tuần tự.
  + Block cuối được padding bằng 0 để đủ 64 bit.

- Test wrong key:
  + Khi giải mã bằng key sai, kết quả thu được không trùng với plaintext ban đầu.

- Test tamper:
  + Khi ciphertext bị thay đổi, kết quả giải mã sai, chứng minh tính nhạy của thuật toán với dữ liệu đầu vào.

- TripleDES:
  + Chương trình thực hiện đúng chuỗi EDE và cho ra ciphertext hợp lệ.
  + Giải mã TripleDES khôi phục lại dữ liệu ban đầu khi dùng đúng bộ khóa.

Kết quả đầu ra luôn là chuỗi nhị phân, phù hợp để hệ thống CI kiểm tra tự động.

## Kết luận / Conclusion

Qua bài lab, em đã hiểu rõ hơn về cách hoạt động của thuật toán DES, đặc biệt là cơ chế Feistel và quá trình sinh khóa vòng. 
Việc triển khai thực tế giúp em nắm rõ cách xử lý dữ liệu theo block và những vấn đề phát sinh như padding.

Ngoài ra, em cũng hiểu được cách mở rộng từ DES sang TripleDES để tăng độ an toàn, cũng như vai trò của việc kiểm thử với nhiều trường hợp khác nhau (đúng, sai key, tamper).

Hạn chế:
- Sử dụng zero padding nên không phân biệt được dữ liệu thật và padding.
- Chưa tối ưu về hiệu năng.
- Chưa xử lý các chuẩn padding an toàn hơn như PKCS#5/PKCS#7.

Hướng phát triển:
- Cải tiến padding.
- Hỗ trợ đọc/ghi file thay vì chỉ stdin.
- Mở rộng sang các thuật toán hiện đại hơn như AES.