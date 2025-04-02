--エーリアン・マーズ
--Alien Mars
function c99532708.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTarget(c99532708.distg)
	c:RegisterEffect(e1)
end
c99532708.counter_list={COUNTER_A}
function c99532708.distg(e,c)
	return c:GetCounter(COUNTER_A)>0 and c:GetCode()~=c99532708
end