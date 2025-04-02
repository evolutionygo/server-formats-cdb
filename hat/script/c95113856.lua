--幻子力空母エンタープラズニル
--Phantom Fortress Enterblathnir
function c95113856.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,nil,9,2)
	c:EnableReviveLimit()
	--Banish from your opp Field, Hand, GY or Decktop
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc95113856(c95113856,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c95113856.target)
	e1:SetOperation(c95113856.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
end
function c95113856.rmfilter(c)
	return c:IsAbleToRemove() and (not c:IsLocation(LOCATION_GRAVE) or aux.SpElimFilter(c))
end
function c95113856.bansc(tp,loc) --Banish check shortcut
	return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,loc,1,nil)
end
function c95113856.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95113856.rmfilter,tp,0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK,1,nil) end
	local b1=c95113856.bansc(tp,LOCATION_ONFIELD)
	local b2=c95113856.bansc(tp,LOCATION_HAND)
	local b3=(Duel.IsPlayerAffectedByEffect(1-tp,69832741) and c95113856.bansc(tp,LOCATION_MZONE)) or c95113856.bansc(tp,LOCATION_GRAVE)
	local b4=c95113856.bansc(tp,LOCATION_DECK)
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc95113856(c95113856,1)},
		{b2,aux.Stringc95113856(c95113856,2)},
		{b3,aux.Stringc95113856(c95113856,3)},
		{b4,aux.Stringc95113856(c95113856,4)})
	e:SetLabel(op)
end
function c95113856.operation(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
		if #g>0 then
			Duel.HintSelection(g)
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	elseif op==2 then
		local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
		if #g>0 then
			local sg=g:RandomSelect(tp,1)
			Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		end
	elseif op==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g
		if Duel.IsPlayerAffectedByEffect(1-tp,69832741) then
			g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
		else
			g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
		end
		if #g>0 then
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	elseif op==4 then
		local g=Duel.GetDecktopGroup(1-tp,1)
		if #g>0 then
			Duel.DisableShuffleCheck()
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
end