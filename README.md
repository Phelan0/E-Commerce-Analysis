# 🛍E-Commerce-Analysis

## ✏️Table of contents:
[1. Project Name](#1-project-name)  
[2. Summary](#2-summary)  
[3. Data source](#3-data-source)  
[4. Tools and analysis method](#4-tools-and-analysis-method)  
[5. Implementation](#5-implementation)  
[6. Dashboard](#6-dashboard)  
[7. Results and Findings](#7-results-and-findings)  
[8. Conclusion](#8-conclusion)  
[9. Recommendations](#9-recommendations)

## 1. Project Name  
### 📍Phân tích sàn thương mại điện tử Olist Store

## 2. Summary
Gia tăng tỉ lệ người dùng quay lại mua hàng, gia tăng khách hàng mới bằng cách phân tích dữ liệu hóa đơn của các đơn hàng đã được tạo trên sàn thương mại điện tử Olist Store

## 3. Data source  
Đây là tập dữ liệu công khai thương mại điện tử của Brazil về các đơn hàng được thực hiện tại Olist Store . Tập dữ liệu có thông tin về khoảng 100 nghìn đơn hàng từ năm 2016 đến năm 2018 được thực hiện tại nhiều thị trường ở Brazil. Các tính năng của nó cho phép xem đơn hàng từ nhiều chiều: từ trạng thái đơn hàng, giá cả, thanh toán và hiệu suất vận chuyển đến vị trí khách hàng, thuộc tính sản phẩm và cuối cùng là các đánh giá do khách hàng viết. Lưu ý dữ liệu được trích xuất từ hóa đơn của các đơn hàng đã được tạo.
  * Nguồn Dataset: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

![image](https://github.com/user-attachments/assets/da1593e1-72e9-4800-93ff-9b6809728b4f)

## 4. Tools and analysis method  
- SQL Server
  * Sử dụng DQL (Data Query Language): select
  * Sử dụng DDL (Data Definition Language): create, alter
  * Sử dụng DML (Data Manipulation Language): update
  * Sử dụng join: left join
- Power BI
  * Sử dụng Aggregate Functions (Hàm tổng hợp): 
  * Sử dụng Logical Functions (Hàm điều kiện):
  * Sử dụng Time Intelligence Functions (Hàm thời gian):
  * Sử dụng Filter Functions (Hàm lọc):
  * Sử dụng Mathematical Functions (Hàm toán học):

## 5. Implementation  
- Xử lý dữ liệu: Sử dụng Sql để làm sạch dữ liệu, tạo mối liên kết cho các bảng, nhóm các trường dữ liệu sử dụng.
- Phân tích: Phân tích tỉ lệ khách hàng quay lại, hiện trạng khách hàng mới tìm đến, tìm các yếu tố liên quan và ảnh hưởng đến 2 nhóm khách hàng trên và phát triển các yếu tố tích cực, giảm thiểu các yếu tố tiêu cực.
- Trực quan hóa dữ liệu: Xây dựng các biểu đồ theo dõi các yếu tố tác động trực tiếp cũng như gián tiếp vào 2 nhóm khách hàng.
 
## 6. Dashboard
![Screenshot 2024-10-08 205329](https://github.com/user-attachments/assets/3fc4992a-bcf9-4eb1-8081-b56dced90985)

![Screenshot 2024-10-08 205351](https://github.com/user-attachments/assets/dbe57118-b020-47d8-bc85-49869ad722da)

![Screenshot 2024-10-08 205412](https://github.com/user-attachments/assets/5a3d2baf-e094-40c3-abbf-faabaaa4d997)

![Screenshot 2024-10-08 205512](https://github.com/user-attachments/assets/fcf74d97-be04-4482-9e8a-a3adc826f5d5)



## 7. Results and Findings 
- Mới chỉ đến tháng 8 năm 2018 nhưng các dữ liệu chỉ số dòng tiền, lượng đơn, người mua, người bán đã cao hơn so với cả năm 2017.
- Khu vực tập trung lượng người mua lớn nhất là ở bang São Paulo (SP), đồng thời đây cũng là bang có dòng tiền giao dịch trên sàn lớn nhất.
- Tỉ lệ khách hàng quay lại chiếm 15,07% so với tổng lượng khách.
- Tỉ lệ sử dụng voucher của nhóm khách hàng quay lại là 14,36%, cũng tỉ lệ đó nhưng ở nhóm khách hàng mua 1 lần chỉ có 1,19%.
- Top 3 nhóm sản phẩm được lựa chọn mua lại nhiều nhất là bed bath table, furniture decor, sports leisure.
- Top 3 nhóm sản phẩm được lựa chọn mua nhiều nhất của nhóm khách hàng chỉ mua 1 lần là health beauty, bed bath table, sports leisure.
- Tỉ lệ giao hàng trễ hẹn của nhóm người quay lại mua hàng là 5,59%, vẫn tỉ lệ đó ở nhóm người chỉ mua hàng 1 lần là 6,81%.
- Phần lớn thời gian dự kiến của các đơn hàng là trong 1 tháng, 3 tuần, 5 tuần. Nhưng trên thực tế đa số thời gian giao hàng chỉ mất từ 1 đến 3 tuần.
## 8. Conclusion  
- Sự phát triển, quy mô đã mở rộng hơn về dòng tiền, lượng đơn, người mua, người bán.
- Khách hàng có xu hướng quay lại mua hàng nhiều hơn khi sử dụng voucher.
- Nhóm sản phẩm mà khách hàng mua lại thường là nhóm sản phẩm về đồ dùng trong phòng, trang trí nội thất, thể thao và giải trí. Đây là những sản phẩm có thể nâng cấp và thay thế thường xuyên, thay đổi theo phong cách và sở thích.
- Đã có sự thay đổi khi nhóm sản phẩm về sức khỏe và sắc đẹp được lựa chọn mua nhiều nhất cho thấy sự quan tâm của khách hàng đối với sức khỏe và nhan sắc bản thân.
- Thời gian giao hàng dự kiến so với thời gian giao hàng thực tế đa số chênh lệch nhau 2 tuần.
- 3 bang RJ, ES, DF không nằm trong top các bang có nhiều thành phố nhất nhưng lại nằm trong top 10 bang có giao dịch về tiền lớn nhất.
## 9. Recommendations
- Tăng tỉ lệ khách hàng quay lại mua hàng trên sàn Olist Store:
   * Tăng thêm các chính sách ưu đãi đối với khách hàng sử dụng voucher.
   * Đối với nhóm khách hàng đã quay lại mua hàng, tiếp tục đẩy mạnh quảng cáo và khuyến mại cho nhóm các sản phẩm có thể thay đổi liên tục như bed bath table, furniture decor, sports leisure.
   * Tiếp tục cải thiện chất lượng giao hàng để giảm tỉ lệ giao hàng trễ hẹn.
   * Cải thiện chất lượng của nhóm sản phẩm về sức khỏe sắc đẹp để tăng nhu cầu quay lại mua hàng của nhóm khách hàng sử dụng sản phẩm này.
- Tăng lượng khách hàng mới mua hàng qua sàn Olist Store:
   * Tiếp tục đẩy mạnh quảng cáo ở các khu vực có giao dịch dòng tiền lớn đặc biệt là 3 bang RJ, ES, DF
   * Sử dụng nhóm các sản phẩm có lượt bán cao nhất là bed bath table, sports leisure, health beauty để tiếp cận các khu vực mới.
   * Sử dụng các chính sách ưu đãi cho các sản phẩm có nhiều lượt mua ở các khu vực có lượt mua thấp.
   * Cân nhắc thay đổi rút ngắn thời gian giao hàng dự kiến, chênh lệch so với thời gian giao hàng thực tế từ 3 - 4 ngày thay vì 2 tuần như hiện tại.
