package util

var byteArr = func() []byte {
	var bs []byte
	for i := 'a'; i < 'z'+1; i++ {
		bs = append(bs, byte(i))
	}
	for i := 'A'; i < 'Z'+1; i++ {
		bs = append(bs, byte(i))
	}
	return bs
}()
