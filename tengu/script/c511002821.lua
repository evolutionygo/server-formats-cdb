--アーマード・サイバーン (Anime)
--Armored Cybern (Anime)
--fixed by Larry126
function c511002821.initial_effect(c)
	--Union procedure
	aux.AddUnionProcedure(c,c511002821.eqfilter,true)
	--Make the equipped monster lose 1000 ATK until the End Phase and destroy 1 card your opponent controls
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002821(c511002821,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c511002821.destg)
	e1:SetOperation(c511002821.desop)
	c:RegisterEffect(e1)
end
c511002821.listed_series={SET_CYBER}
function c511002821.eqfilter(c)
	return c:IsSetCard(SET_CYBER) and c:IsRace(RACE_MACHINE)
end
function c511002821.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	local ec=e:GetHandler():GetEquipTarget()
	if chk==0 then return ec and ec:IsAttackAbove(1000)
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,ec,1,tp,1000)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
end
function c511002821.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if ec and ec:IsAttackAbove(1000) and ec:UpdateAttack(-1000,RESETS_STANDARD_PHASE_END,c)==-1000 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end