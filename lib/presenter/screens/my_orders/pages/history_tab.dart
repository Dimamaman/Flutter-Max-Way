import 'package:flutter/material.dart';

class Tab2 extends StatelessWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
/*      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(height: 120,'assets/images/place_holder.png'),
          const SizedBox(height: 20),
          const Text("Buyurtma mavjud emas",style: TextStyle(color: Colors.grey),),
          const SizedBox(height: 50,)
        ],
      ))*/
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Material(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: InkWell(
              onTap: (){},
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 90,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Buyurtma №123456', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue[50]
                          ),
                          child: const Text('Buyurtma tugallandi', style: TextStyle(color: Colors.blue)),
                        )
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('12 000 so\'m', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Row(
                          children: [
                            Icon(Icons.date_range_rounded, size: 15,color: Colors.grey[600]),
                            const SizedBox(width: 3),
                            Text('05.09.2023', style: TextStyle(color: Colors.grey[600], fontSize: 15))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
