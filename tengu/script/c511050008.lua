--ブリキの大公 (Anime)
--Tin Archduke (Anime)
function c511050008.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon Procedure
	aux.AddXyzProcedure(c,nil,4,3)
	--Change the battle position of all monsters your opponent controls
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511050008(c511050008,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c511050008.tg)
	e1:SetOperation(c511050008.op)
	c:RegisterEffect(e1)
end
function c511050008.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE,nil)>0 end
	local sg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,#sg,0,0)
end
function c511050008.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,nil)
	if #tc>0 then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
	end
end