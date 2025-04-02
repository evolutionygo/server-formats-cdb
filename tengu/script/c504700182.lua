--鉄の騎士 ギア・フリード
--Gearfried the Iron Knight (GOAT)
--effect is continuous
function c504700182.initial_effect(c)
	--destroy equip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_EQUIP)
	e1:SetTarget(c504700182.destg)
	e1:SetOperation(c504700182.desop)
	c:RegisterEffect(e1)
end
function c504700182.filter(c,ec)
	return c:GetEquipTarget()==ec
end
function c504700182.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c504700182.filter,1,nil,e:GetHandler()) end
	local dg=eg:Filter(c504700182.filter,nil,e:GetHandler())
	e:SetLabelObject(dg)
end
function c504700182.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetLabelObject()
	Duel.Destroy(tg,REASON_EFFECT)
end