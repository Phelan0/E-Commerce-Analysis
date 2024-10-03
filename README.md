# 🛍E-Commerce-Analysis

## ✏️Các thao tác chính bao gồm
Dự án tập trung sử dụng dữ liệu từ các đơn hàng đã được tạo nhằm phân tích và có cái nhìn tổng quán về hoạt động của sàn thương mại điện tử với các thao tác chính bao gồm:
- Sử dụng khóa chính khóa ngoại để tạo liên kết giữa các bảng
- Sử dụng DQL(Data Query Language) để truy vấn kiểm tra dữ liệu
- Sử dụng DDL (Data Definition Language) để định nghĩa dữ liệu 
- Sử dụng DML(Data Manipulation Language) để cập nhật dữ liệu
- Sử dụng Join để ghép dữ liệu từ các bảng phục vụ cho phân tích
- Sử dụng Power BI để trực quan hóa dữ liệu từ đó có thể đưa ra góc nhìn tổng quát về hoạt động của sản thương mại điện tử thông qua các đơn hàng đã được tạo.

## ✏️Thông tin dữ liệu (Dataset)
![image](https://github.com/user-attachments/assets/da1593e1-72e9-4800-93ff-9b6809728b4f)

### Dữ liệu bảng gốc:
#### 1. Bảng customers
- customer_id: Đây là khóa liên kết đến tập dữ liệu đơn hàng. Mỗi đơn hàng sẽ có một giá trị customer_id duy nhất, giúp xác định đơn hàng nào thuộc về người mua nào.
- customer_unique_id: Là định danh duy nhất cho mỗi người mua. Điều này đảm bảo rằng mỗi người mua chỉ có một customer_unique_id, ngay cả khi họ có thể có nhiều đơn hàng.
- customer_zip_code_prefix: Đây là 5 chữ số đầu tiên của mã bưu điện (zip code) của người mua.
- customer_city: Tên thành phố của người mua.
- customer_state: Tên bang của người mua. 
#### 2. Bảng sellers
- seller_id: Là định danh duy nhất cho mỗi người bán. Mỗi người bán sẽ có một seller_id khác nhau, giúp xác định người bán cụ thể.
- seller_zip_code_prefix: Đây là 5 chữ số đầu tiên của mã bưu điện (zip code) của người bán. 
- seller_city: Tên thành phố của người bán. 
- seller_state: Tên bang của người bán.
#### 3. Bảng products
- product_id: Định danh duy nhất của từng sản phẩm, được sử dụng để phân biệt giữa các sản phẩm khác nhau.
- product_category_name: Tên danh mục gốc của sản phẩm, viết bằng tiếng Bồ Đào Nha. Danh mục này giúp phân loại sản phẩm vào các nhóm hàng hóa cụ thể.
- product_name_length: Số ký tự được lấy từ tên sản phẩm. 
- product_description_length: Số ký tự trong phần mô tả sản phẩm.
- product_photos_qty: Số lượng hình ảnh của sản phẩm được công bố.
- product_weight_g: Trọng lượng sản phẩm tính bằng gram. 
- product_length_cm: Chiều dài của sản phẩm tính bằng centimet.
- product_height_cm: Chiều cao của sản phẩm tính bằng centimet.
- product_width_cm: Chiều rộng của sản phẩm tính bằng centimet.
#### 4. Bảng orders
- order_id: Định danh duy nhất của từng đơn hàng, được sử dụng để phân biệt giữa các đơn hàng khác nhau.
- customer_id: Khóa liên kết với bảng khách hàng. Mỗi đơn hàng sẽ có một customer_id duy nhất để nhận diện khách hàng đã thực hiện đơn hàng đó.
- order_status: Trạng thái của đơn hàng, chẳng hạn như "delivered" (đã giao hàng), "shipped" (đã chuyển hàng), v.v. 
- order_purchase_timestamp: Thời điểm khách hàng mua hàng, tức là thời gian mà đơn hàng được đặt trên hệ thống.
- order_approved_at: Thời điểm thanh toán cho đơn hàng được phê duyệt.
- order_delivered_carrier_date: Thời điểm đơn hàng được giao cho đối tác logistic để vận chuyển.
- order_delivered_customer_date: Thời điểm thực tế mà khách hàng nhận được đơn hàng.
- order_estimated_delivery_date: Ngày giao hàng dự kiến mà khách hàng nhận được khi họ thực hiện mua hàng. 
#### 5. Bảng order_items
- order_id: Định danh duy nhất của đơn hàng. Mỗi đơn hàng có một order_id để phân biệt với các đơn hàng khác.
- order_item_id: Số thứ tự xác định số lượng mục hàng được bao gồm trong cùng một đơn hàng. Nếu một đơn hàng có nhiều mục hàng, các mục này sẽ được đánh số tuần tự.
- product_id: Định danh duy nhất của sản phẩm. 
- seller_id: Định danh duy nhất của người bán.
- shipping_limit_date: Ngày giới hạn mà người bán cần giao sản phẩm cho đối tác logistic. Trường này cho biết thời hạn tối đa để người bán xử lý và gửi hàng.
- price: Giá của sản phẩm trong đơn hàng. Đây là chi phí mà khách hàng trả cho mỗi mục hàng trong đơn hàng.
- freight_value: Phí vận chuyển của từng mục hàng. Nếu một đơn hàng có nhiều mục hàng, phí vận chuyển sẽ được chia đều cho các mục hàng tương ứng.
#### 6. Bảng order_payments
- order_id: Định danh duy nhất của đơn hàng. Mỗi đơn hàng sẽ có một order_id để phân biệt với các đơn hàng khác.
- payment_sequential: Cho biết thứ tự của các phương thức thanh toán nếu khách hàng thanh toán đơn hàng bằng nhiều phương thức khác nhau. Nếu khách hàng sử dụng nhiều phương thức thanh toán, một chuỗi số thứ tự sẽ được tạo ra để xác định mỗi phương thức thanh toán.
- payment_type: Phương thức thanh toán mà khách hàng đã chọn để thanh toán đơn hàng, chẳng hạn như thẻ tín dụng, thẻ ghi nợ, ví điện tử, chuyển khoản, v.v.
- payment_installments: Số lần thanh toán mà khách hàng đã chọn khi thanh toán đơn hàng. Một số phương thức thanh toán cho phép chia nhỏ số tiền phải trả thành nhiều đợt (trả góp).
- payment_value: Giá trị của giao dịch thanh toán, tức là số tiền đã thanh toán cho mỗi lần giao dịch.
#### 7. Bảng order_reviews
- review_id: Định danh duy nhất của đánh giá. Mỗi đánh giá sẽ có một review_id để phân biệt với các đánh giá khác.
- order_id: Định danh duy nhất của đơn hàng. Liên kết đánh giá với đơn hàng mà khách hàng đã mua.
- review_score: Điểm đánh giá được khách hàng chấm trong cuộc khảo sát hài lòng, với thang điểm từ 1 (rất không hài lòng) đến 5 (rất hài lòng).
- review_comment_title: Tiêu đề của bình luận do khách hàng để lại trong đánh giá, viết bằng tiếng Bồ Đào Nha.
- review_comment_message: Nội dung bình luận do khách hàng để lại trong đánh giá, viết bằng tiếng Bồ Đào Nha.
- review_creation_date: Ngày mà cuộc khảo sát hài lòng được gửi đến khách hàng, yêu cầu đánh giá về đơn hàng.
- review_answer_timestamp: Thời gian mà khách hàng trả lời cuộc khảo sát hài lòng, thể hiện khi nào đánh giá được gửi lại.
#### 8. Bảng geolocation
- geolocation_zip_code_prefix: Các chữ số đầu tiên của mã bưu chính (zip code).
- geolocation_lat: Vĩ độ (latitude) của địa điểm.
- geolocation_lng: Kinh độ (longitude) của địa điểm.
- geolocation_city: Tên của thành phố.
- geolocation_state: Tên của bang.
#### 9.Bảng translation
- product_category_name: Tên danh mục sản phẩm được ghi bằng tiếng Bồ Đào Nha.
- product_category_name_english: Tên danh mục sản phẩm được dịch sang tiếng Anh.
