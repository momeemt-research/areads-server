import cv2

def main():
    capture = cv2.VideoCapture(0)
    capture.set(cv2.CAP_PROP_FRAME_WIDTH, 1920)
    capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 1080)
    capture.set(cv2.CAP_PROP_FPS, 30)
    cv2.namedWindow("Video", cv2.WINDOW_NORMAL)

    while True:
        ret, frame = capture.read()
        if not ret:
            break

        if cv2.waitKey(1) == ord("q"):
            break
        cv2.imshow("Video", frame)

main()