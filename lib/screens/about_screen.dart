import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var services = [
    'เขื่อนหินถมแกนดินเหนียว',
    'ความจุอ่างเก็บน้ำ 17,745 ล้านลูกบาศก์เมตร',
    'ความกว้างสันเขื่อน 15 เมตร',
    'ความยาวสันเขื่อน 610 เมตร',
    'เขื่อนศรีนครินทร์เป็นเขื่อนประเภทหินถมแกนดินเหนียวที่สามารถกักเก็บน้ำได้มากที่สุดในประเทศไทย'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('srinakarin-dm'),
        centerTitle: true,
        backgroundColor: Colors.black12,
        // actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset('assets/images/2.jpg'),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'SNR0',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      const Text(
                          'เขื่อนศรีนครินทร์ เป็นเขื่อนอเนกประสงค์ขนาดใหญ่แห่งแรกของโครงการพัฒนาลุ่มน้ำแม่กลอง สร้างขึ้นเพื่ออำนวยประโยชน์ด้านต่างๆ  ส่งเสริมระบบชลประทาน โครงการแม่กลองใหญ่ให้มีประสิทธิภาพยิ่งขึ้น เขื่อนแม่กลองของกรมชลประทานเป็นหัวงานทดน้ำเข้าสู่พื้นที่เกษตรได้ตลอดปีเป็นเนื้อที่ถึง 4 ล้านไร่ สามารถปล่อยน้ำลงผลักดันน้ำเค็มมิให้หนุนล้ำเข้ามาทำความเสียหายแก่พื้นที่บริเวณปากน้ำแม่กลองในช่วงฤดูแล้ง การประมง บรรเทาอุทกภัย การท่องเที่ยว\n\n เขื่อนศรีนครินทร์นับเป็นแหล่งท่องเที่ยว พักผ่อนหย่อนใจที่สวยงามอีกแห่งหนึ่ง ในจังหวัดกาญจนบุรีให้ทั้งความรู้และความเพลิดเพลินแก่ผู้มาเที่ยวชมปีละเป็นจำนวนกว่าแสนคน และก่อให้เกิดการขยายตัวทางการท่องเที่ยวอย่างกว้างขวาง เช่น แพท่องเที่ยวในอ่างเก็บน้ำ เป็นต้น\n\n พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร ได้พระราชทานพระบรมราชานุญาตให้เชิญพระนามาภิไธย สมเด็จพระศรีนครินทร์ มาขนานนามเขื่อน และเสด็จพระราชดำเนินพร้อมด้วยสมเด็จพระกนิษฐาธิราชเจ้า กรมสมเด็จพระเทพรัตนราชสุดาฯ สยามบรมราชกุมารี ไปทรงเปิดเขื่อน เมื่อวันที่ 15 มิถุนายน พ.ศ. 2524'),
                      const Divider(),
                      const Row(
                        children: [
                          Expanded(
                              child: Icon(
                            Icons.pages,
                            color: Colors.amber,
                            size: 100,
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เขื่อนศรีนครินทร์ 300 หมู่ 4 ต.ท่ากระดาน อ.ศรีสวัสดิ์ จ.กาญจนบุรี 71250',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text('0 3457 4248, 0 3457 4001 ต่อ 2010')
                            ],
                          ))
                        ],
                      ),
                      const Text('ลักษณะเขื่อน'),
                      Wrap(
                        spacing: 6.0,
                        children: [
                          for (var v in services)
                            Chip(
                              label: Text(v),
                              backgroundColor: Colors.grey.shade200,
                              avatar: const Icon(Icons.add_home_work),
                            )
                        ],
                      ),
                      // const Spacer(flex: 2,),
                      const Divider(),
                      const Text('Credit'),
                      credit(),
                      booking()
                    ],
                  ))),
        ]),
      ),
    );
  }
}

Container credit() {
  return Container(
    margin: const EdgeInsets.only(top: 25),
    decoration: const BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    padding: const EdgeInsets.all(5),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          foregroundImage: AssetImage('assets/images/3.PNG'),
          radius: 40,
        ),
        CircleAvatar(
          foregroundImage: AssetImage('assets/images/3.PNG'),
          radius: 40,
        ),
        CircleAvatar(
          foregroundImage: AssetImage('assets/images/3.PNG'),
          radius: 40,
        ),
        SizedBox(
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.home_max),
              Icon(Icons.home_max),
              Icon(Icons.home_max),
            ],
          ),
        )
      ],
    ),
  );
}

Container booking() {
  return Container(
      height: 350,
      margin: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 234, 234),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'บ้านครินทร์ (Karin)',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'จำนวนผู้เข้าพักสูงสุด: 4',
                  style: TextStyle(color: Color.fromARGB(255, 11, 77, 131)),
                ),
              ),
              Expanded(
                  child: Row(
                // mainAxisAlignment: MainAxisAlignment.end
                children: [
                  Text('Review 4.3',
                      style:
                          TextStyle(color: Color.fromARGB(255, 11, 77, 131))),
                  Icon(
                    Icons.star_rate_sharp,
                    color: Color.fromRGBO(255, 230, 7, 1),
                    size: 35,
                  )
                ],
              ))
            ],
          ),
          Expanded(child: Image.asset('assets/images/karin.jpg'))
        ],
      ));
}
