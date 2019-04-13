## Quy trình phát triển các ứng dụng dựa trên bộ chứa Docker.
- Lựa chọn công cụ phát triển: IDE hoặc trình soạn thảo
- Ngôn ngữ và platform
- Mỗi vùng chứa (một thể hiện của hình ảnh Docker) bao gồm các thành phần sau:
 + Lựa chọn hệ điều hành. ví dụ: bản phân phối Linux, Windows Nano Server hoặc Windows Server Core.
 + Các tệp được thêm trong quá trình phát triển, ví dụ, mã nguồn và nhị phân ứng dụng.
 + Thông tin cấu hình, chẳng hạn như cài đặt môi trường và phụ thuộc.

[Quy trình từng bước để phát triển các ứng dụng được chứa trong Docker](https://docs.microsoft.com/en-us/dotnet/standard/microservices-architecture/docker-application-development-process/media/image1.png)

## Thông số kỹ thuật ứng dụng - Application specifications
Ứng dụng sẽ bao gồm các loại thành phần này:
- Thành phần trình bày(Presentation components). Chúng chịu trách nhiệm xử lý UI và tiêu thụ các dịch vụ từ xa.

- Tên miền hoặc logic kinh doanh(Domain or business logic). Đây là logic miền của ứng dụng.

- Cơ sở dữ liệu logic truy cập(Database access logic). Điều này bao gồm các thành phần truy cập dữ liệu chịu trách nhiệm truy cập cơ sở dữ liệu (SQL hoặc NoQuery).

- Ứng dụng logic tích hợp(Application integration logic.). Điều này bao gồm một kênh nhắn tin, chủ yếu dựa trên các nhà môi giới tin nhắn.

## Bối cảnh nhóm phát triển - Development team context
Bạn có nhiều nhóm phát triển tập trung vào các lĩnh vực kinh doanh khác nhau của ứng dụng.

Các thành viên mới của nhóm phải nhanh chóng làm việc hiệu quả và ứng dụng phải dễ hiểu và sửa đổi.

Ứng dụng này sẽ có một sự phát triển lâu dài và các quy tắc kinh doanh luôn thay đổi.

Bạn cần khả năng bảo trì dài hạn tốt, có nghĩa là có sự nhanh nhẹn khi thực hiện các thay đổi mới trong tương lai trong khi có thể cập nhật nhiều hệ thống con với tác động tối thiểu lên các hệ thống con khác.

Bạn muốn thực hành tích hợp liên tục và triển khai ứng dụng liên tục.

Bạn muốn tận dụng các công nghệ mới nổi (khung, ngôn ngữ lập trình, v.v.) trong khi phát triển ứng dụng. Bạn không muốn thực hiện chuyển đổi hoàn toàn ứng dụng khi chuyển sang công nghệ mới, vì điều đó sẽ dẫn đến chi phí cao và ảnh hưởng đến khả năng dự đoán và tính ổn định của ứng dụng.

## Chọn một kiến trúc - Choosing an architecture
Kiến trúc triển khai ứng dụng nên là gì?
Giao thức giao tiếp?

### Lợi ích của giải pháp dựa trên microservice 
Một giải pháp dựa trên microservice như thế này có nhiều lợi ích:

Mỗi microservice tương đối nhỏ, dễ quản lý và phát triển . Đặc biệt:

Thật dễ dàng để một nhà phát triển hiểu và bắt đầu nhanh chóng với năng suất tốt.

Các container bắt đầu nhanh, điều này làm cho các nhà phát triển có năng suất cao hơn.

Một IDE như Visual Studio có thể tải nhanh các dự án nhỏ hơn, giúp các nhà phát triển làm việc hiệu quả.

Mỗi microservice có thể được thiết kế, phát triển và triển khai độc lập với các dịch vụ siêu nhỏ khác, điều này mang lại sự nhanh nhẹn vì việc triển khai các phiên bản mới của microservice thường xuyên dễ dàng hơn.

Có thể mở rộng ra từng khu vực riêng biệt của ứng dụng . Ví dụ, dịch vụ danh mục hoặc dịch vụ giỏ có thể cần được thu nhỏ lại, nhưng không phải là quy trình đặt hàng. Một cơ sở hạ tầng microservice sẽ hiệu quả hơn nhiều đối với các tài nguyên được sử dụng khi nhân rộng ra so với kiến trúc nguyên khối.

Bạn có thể phân chia công việc phát triển giữa nhiều nhóm . Mỗi dịch vụ có thể được sở hữu bởi một nhóm phát triển duy nhất. Mỗi nhóm có thể quản lý, phát triển, triển khai và mở rộng quy mô dịch vụ của họ một cách độc lập với các nhóm còn lại.

Các vấn đề bị cô lập nhiều hơn . Nếu có sự cố trong một dịch vụ, chỉ có dịch vụ đó bị ảnh hưởng ban đầu (trừ khi sử dụng thiết kế sai, với sự phụ thuộc trực tiếp giữa microservice) và các dịch vụ khác có thể tiếp tục xử lý các yêu cầu. Ngược lại, một thành phần trục trặc trong kiến trúc triển khai nguyên khối có thể làm sập toàn bộ hệ thống, đặc biệt là khi nó liên quan đến các tài nguyên, chẳng hạn như rò rỉ bộ nhớ. Ngoài ra, khi sự cố trong microservice được giải quyết, bạn chỉ có thể triển khai microservice bị ảnh hưởng mà không ảnh hưởng đến phần còn lại của ứng dụng.

Bạn có thể sử dụng các công nghệ mới nhất . Vì bạn có thể bắt đầu phát triển các dịch vụ một cách độc lập và chạy chúng cạnh nhau (nhờ các container và .NET Core), bạn có thể bắt đầu sử dụng các công nghệ và khung mới nhất một cách nhanh chóng thay vì bị mắc kẹt trên một ngăn xếp hoặc khung cũ hơn cho toàn bộ ứng dụng.

### Nhược điểm của một giải pháp dựa trên microservice 
Một giải pháp dựa trên microservice như thế này cũng có một số nhược điểm:

Ứng dụng phân tán . Phân phối ứng dụng làm tăng thêm sự phức tạp cho các nhà phát triển khi họ đang thiết kế và xây dựng các dịch vụ. Ví dụ: các nhà phát triển phải triển khai giao tiếp dịch vụ giao thoa bằng các giao thức như HTTP hoặc AMPQ, điều này làm tăng thêm độ phức tạp để kiểm tra và xử lý ngoại lệ. Nó cũng thêm độ trễ cho hệ thống.

Triển khai phức tạp . Một ứng dụng có hàng tá loại microservice và cần khả năng mở rộng cao (nó cần có khả năng tạo nhiều phiên bản cho mỗi dịch vụ và cân bằng các dịch vụ đó trên nhiều máy chủ) có nghĩa là mức độ phức tạp triển khai cao cho hoạt động và quản lý CNTT. Nếu bạn không sử dụng cơ sở hạ tầng theo định hướng microservice (như bộ điều phối và bộ lập lịch), thì sự phức tạp bổ sung đó có thể đòi hỏi nhiều nỗ lực phát triển hơn nhiều so với chính ứng dụng kinh doanh.

Giao dịch nguyên tử . Các giao dịch nguyên tử giữa nhiều microservice thường là không thể. Các yêu cầu kinh doanh phải chấp nhận sự thống nhất cuối cùng giữa nhiều dịch vụ siêu nhỏ.

Nhu cầu tài nguyên toàn cầu tăng (tổng bộ nhớ, ổ đĩa và tài nguyên mạng cho tất cả các máy chủ hoặc máy chủ). Trong nhiều trường hợp, khi bạn thay thế một ứng dụng nguyên khối bằng cách tiếp cận microservice, lượng tài nguyên toàn cầu ban đầu cần thiết cho ứng dụng dựa trên microservice mới sẽ lớn hơn nhu cầu cơ sở hạ tầng của ứng dụng nguyên khối ban đầu. Điều này là do mức độ chi tiết và dịch vụ phân tán cao hơn đòi hỏi nhiều nguồn lực toàn cầu hơn. Tuy nhiên, do chi phí tài nguyên nói chung thấp và lợi ích của việc có thể mở rộng chỉ một số lĩnh vực nhất định của ứng dụng so với chi phí dài hạn khi phát triển các ứng dụng nguyên khối, việc sử dụng tài nguyên tăng lên thường là một sự đánh đổi tốt trong thời gian dài ứng dụng -term.

Các vấn đề với giao tiếp khách hàng trực tiếp đến microservice . Khi ứng dụng lớn, với hàng tá dịch vụ siêu nhỏ, sẽ có những thách thức và hạn chế nếu ứng dụng yêu cầu giao tiếp trực tiếp giữa khách hàng với microservice. Một vấn đề là sự không phù hợp tiềm năng giữa nhu cầu của khách hàng và các API được hiển thị bởi mỗi dịch vụ siêu nhỏ. Trong một số trường hợp nhất định, ứng dụng khách có thể cần thực hiện nhiều yêu cầu riêng biệt để soạn UI, có thể không hiệu quả qua Internet và sẽ không thực tế trên mạng di động. Do đó, các yêu cầu từ ứng dụng khách đến hệ thống back-end nên được giảm thiểu.

Một vấn đề khác với giao tiếp trực tiếp từ khách hàng đến microservice là một số dịch vụ siêu nhỏ có thể đang sử dụng các giao thức không thân thiện với Web. Một dịch vụ có thể sử dụng giao thức nhị phân, trong khi dịch vụ khác có thể sử dụng nhắn tin AMQP. Các giao thức này không thân thiện với tường lửa và được sử dụng tốt nhất trong nội bộ. Thông thường, một ứng dụng nên sử dụng các giao thức như HTTP và WebSockets để liên lạc bên ngoài tường lửa.

Một nhược điểm khác với cách tiếp cận dịch vụ khách hàng trực tiếp này là nó gây khó khăn cho việc cấu trúc lại các hợp đồng cho các dịch vụ siêu nhỏ đó. Theo thời gian, các nhà phát triển có thể muốn thay đổi cách hệ thống được phân vùng thành các dịch vụ. Ví dụ: họ có thể hợp nhất hai dịch vụ hoặc tách một dịch vụ thành hai hoặc nhiều dịch vụ. Tuy nhiên, nếu khách hàng giao tiếp trực tiếp với các dịch vụ, thực hiện loại tái cấu trúc này có thể phá vỡ tính tương thích với các ứng dụng khách.

Như đã đề cập trong phần kiến trúc, khi thiết kế và xây dựng một ứng dụng phức tạp dựa trên microservice, bạn có thể xem xét việc sử dụng nhiều Cổng API chi tiết thay vì cách tiếp cận giao tiếp khách hàng trực tiếp đơn giản hơn.

Phân vùng microservice . Cuối cùng, bất kể bạn sử dụng phương pháp tiếp cận nào cho kiến trúc microservice của mình, một thách thức khác là quyết định cách phân vùng ứng dụng đầu cuối thành nhiều dịch vụ siêu nhỏ. Như đã lưu ý trong phần kiến trúc của hướng dẫn, có một số kỹ thuật và cách tiếp cận bạn có thể thực hiện. Về cơ bản, bạn cần xác định các khu vực của ứng dụng được tách rời khỏi các khu vực khác và có số lượng phụ thuộc cứng thấp. Trong nhiều trường hợp, điều này được liên kết với các dịch vụ phân vùng theo trường hợp sử dụng. Ví dụ: trong ứng dụng cửa hàng điện tử của chúng tôi, chúng tôi có một dịch vụ đặt hàng chịu trách nhiệm cho tất cả logic kinh doanh liên quan đến quy trình đặt hàng. Chúng tôi cũng có dịch vụ danh mục và dịch vụ giỏ thực hiện các khả năng khác. Lý tưởng nhất, mỗi dịch vụ chỉ nên có một bộ trách nhiệm nhỏ. Điều này tương tự như nguyên tắc trách nhiệm duy nhất (SRP) được áp dụng cho các lớp, trong đó tuyên bố rằng một lớp chỉ nên có một lý do để thay đổi. Nhưng trong trường hợp này, đó là về microservice, vì vậy phạm vi sẽ lớn hơn một lớp. Trên hết, một dịch vụ siêu nhỏ phải hoàn toàn tự chủ, từ đầu đến cuối, bao gồm cả trách nhiệm đối với các nguồn dữ liệu của chính nó.




