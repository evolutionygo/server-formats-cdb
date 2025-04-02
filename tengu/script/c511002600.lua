--No.88 ギミック・パペット－デステニー・レオ
Duel.LoadCardScript("c48995978.lua")
function c511002600.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--detach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002600(48995978,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511002600.target)
	e1:SetOperation(c511002600.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511002600.indes)
	c:RegisterEffect(e2)
end
c511002600.aux.xyz_number=88
c511002600.listed_series={0x48}
function c511002600.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
end
function c511002600.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)>0 then
		if c:GetOverlayCount()==0 then
			Duel.Win(c:GetControler(),WIN_REASON_PUPPET_LEO)
		end
	end
end
function c511002600.indes(e,c)
	return not c:IsSetCard(0x48)
end