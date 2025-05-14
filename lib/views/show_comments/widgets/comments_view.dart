import 'package:admin_dash_board/core/logic/admin_logic/get_comments/get_rate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/comment_model.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, required this.product_id});

  final String product_id;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  // دالة لفتح المودال للرد
  void _showReplyDialog(BuildContext parentContext, CommentModel comment) {
    final getCommentsCubit = parentContext.read<GetCommentsCubit>();

    final TextEditingController replyController = TextEditingController();
    showDialog(
      context: parentContext,
      builder: (context) {
        replyController.text=comment.replay??'';
        return AlertDialog(
          title: const Text('رد على التعليق'),
          content: TextField(
            controller: replyController,
            decoration: const InputDecoration(hintText: 'اكتب ردك هنا...'),
            maxLines: 5,
            minLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                await getCommentsCubit.addReplies(
                  comment_id: comment.id!,
                  replay: replyController.text,
                );
                await getCommentsCubit.getComments(product_id: comment.forProduct!);
                Navigator.pop(context);
              },
              child: const Text('إرسال الرد'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetCommentsCubit>(
      create:
          (context) =>
              GetCommentsCubit()..getComments(product_id: widget.product_id),
      child: Scaffold(
        appBar: AppBar(title: const Text('التعليقات'), centerTitle: true),
        body: BlocConsumer<GetCommentsCubit, GetCommentsState>(
          builder: (context, state) {
            if (state is GetCommentsSuccess ||state is AddRepliesSuccess ) {
              List<CommentModel> comments = context.read<GetCommentsCubit>().comments;
              if (comments.isEmpty) {
                return Center(child: Text("لا توجد تعليقات لهذا المنشور..."),);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: comments.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentCard(
                        comment: comment,
                        onReply: () => _showReplyDialog(context, comment),

                      );
                    },
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onReply;

  const CommentCard({super.key, required this.comment, required this.onReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم المستخدم + التاريخ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.userName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                comment.createdAt != null
                    ? _formatDate(comment.createdAt!)
                    : '',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // نص التعليق
          Text(comment.comment ?? '', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          // زر الرد إذا لم يكن هناك رد مسبق
          Align(
            alignment: Alignment.centerRight,
            child:
                 TextButton.icon(
                      onPressed: onReply,
                      icon:  Icon(comment.replay == null ?Icons.reply:Icons.reply_all, size: 20),
                      label: Text(comment.replay == null ?'رد':"تعديل الرد"),
                    )

          ),
          // إذا فيه رد مسبق
          if (comment.replay != null && comment.replay!.isNotEmpty) ...[
            const Divider(),
            const Text(
              'رد الأدمن:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(comment.replay!, style: const TextStyle(fontSize: 15)),
          ],
        ],
      ),
    );
  }

  // دالة لتنسيق الوقت بشكل مختصر
  String _formatDate(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    } catch (e) {
      return dateTimeString;
    }
  }
}
