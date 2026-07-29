def square(idx: int) -> int:
    if idx < 1 or idx > 64:
        raise ValueError("square must be between 1 and 64")
    return 2**(idx-1)

def total() -> int:
    return (2**64)-1
