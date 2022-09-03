import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:git_app/app/errors/exceptions.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/extensions/extensions.dart';

class FailureWidget extends StatelessWidget {
  final String? asset;
  final String? message;
  final Failure failure;
  final VoidCallback? onRetry;

  const FailureWidget({
    Key? key,
    required this.failure,
    this.asset,
    this.onRetry,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            asset ?? _getResourceByFailure(),
            height: 200,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? _getMessageByFailure(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: onRetry != null,
            child: Column(
              children: [
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => onRetry?.call(),
                  child:  Text(context.l10n.failureWidgetTryAgain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getResourceByFailure() {
    if (failure is NotFoundFailure) {
      return "assets/empty_states/not_found.svg";
    }
    if (failure is NoConnectionFailure) {
      return "assets/empty_states/no_connection.svg";
    }
    if (failure is NoAuthorizedException) {
      return "assets/empty_states/limit_per_time.svg";
    }
    return "assets/empty_states/failure.svg";
  }

  String _getMessageByFailure(BuildContext context) {
    if (failure is NotFoundFailure) {
      return context.l10n.globalResourceNotFound;
    }
    if (failure is NoConnectionFailure) {
      return context.l10n.globalNoConnectionError;
    }
    if (failure is ServerResposeFailure) {
      return context.l10n.globalUnknownError;
    }
    if (failure is NoAuthorizedException) {
      return context.l10n.globalUnknownError;
    }
    return context.l10n.globalUnknownError;
  }
}
