--アストログラフ・マジシャン (Anime)
--Astrograph Sorcerer (Anime)
--Rescripted by Naim
function c511010507.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010507(c511010507,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c511010507.sptg)
	e1:SetOperation(c511010507.spop)
	c:RegisterEffect(e1)
	--Special Summon Supreme King Z-Arc
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511010507(c511010507,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511010507.zarccost)
	e2:SetTarget(c511010507.zarctg)
	e2:SetOperation(c511010507.zarcop)
	c:RegisterEffect(e2)
end
c511010507.listed_names={CARD_ZARC,41209827,82044279,16195942,16178681}
local ZARC_LOC=LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_EXTRA+LOCATION_DECK
function c511010507.spcfilter(c,e,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and ((c:IsCanBeEffectTarget(e) and (c:IsLocation(LOCATION_SZONE+LOCATION_GRAVE+LOCATION_MZONE) or (c:IsLocation(LOCATION_REMOVED) and c:IsFaceup()))) or (c:IsLocation(LOCATION_HAND+LOCATION_DECK) or (c:IsLocation(LOCATION_EXTRA) and c:IsFaceup())))
end
function c511010507.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c511010507.spcfilter,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,1,tp,false,false) end
	local g=eg:Filter(c511010507.spcfilter,nil,e,tp)
	Duel.SetTargetCard(g)
	if g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)>0 then
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g:Filter(Card.IsLocation,nil,LOCATION_GRAVE),g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE),tp,LOCATION_GRAVE)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_HAND)
end
function c511010507.spcfilterchk(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and (c:IsLocation(LOCATION_SZONE+LOCATION_GRAVE+LOCATION_MZONE) or (c:IsLocation(LOCATION_REMOVED) and c:IsFaceup())) or (c:IsLocation(LOCATION_HAND+LOCATION_DECK) or (c:IsLocation(LOCATION_EXTRA) and c:IsFaceup())) and not Duel.GetFieldCard(tp,c:GetPreviousLocation(),c:GetPreviousSequence())
end
function c511010507.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetTargetCards(e)
	local freezone=true
	for tc in g:Iter() do
		if Duel.GetFieldCard(tp,tc:GetPreviousLocation(),tc:GetPreviousSequence()) then freezone=false end
	end
	if Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)>0 and #g>0 and freezone==true and Duel.SelectEffectYesNo(tp,c) then
		g:KeepAlive()
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_CUSTOM+c511010507)
		e1:SetLabelObject(g)
		e1:SetTarget(c511010507.rettg)
		e1:SetOperation(c511010507.retop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+c511010507,e,r,tp,tp,0)
	end
end
function c511010507.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=e:GetLabelObject()
	Duel.SetTargetCard(g)
	g:DeleteGroup()
end
function c511010507.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e):Filter(c511010507.spcfilterchk,nil,tp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BECOME_LINKED_ZONE)
	e1:SetValue(0xffffff)
	Duel.RegisterEffect(e1,tp)
	for tc in aux.Next(g) do
		if tc:IsPreviousLocation(LOCATION_PZONE) then
			local seq=0
			if tc:GetPreviousSequence()==7 or tc:GetPreviousSequence()==4 then seq=1 end
			Duel.MoveToField(tc,tp,tp,LOCATION_PZONE,tc:GetPreviousPosition(),true,(1<<seq))
		else
			Duel.MoveToField(tc,tp,tp,tc:GetPreviousLocation(),tc:GetPreviousPosition(),true,(1<<tc:GetPreviousSequence()))
		end
	end
	e1:Reset()
end
function c511010507.zarccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511010507.zarcspfilter(c,e,tp,sg)
	return c:IsCode(CARD_ZARC) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,sg+e:GetHandler(),c)>0
end
function c511010507.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511010507.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511010507.rescon(sg,e,tp,mg)
	return sg:IsExists(c511010507.chk,1,nil,sg,Group.CreateGroup(),41209827,82044279,16195942,16178681) and Duel.GetLocationCountFromEx(tp,tp,sg+e:GetHandler(),TYPE_FUSION)>0
end
function c511010507.zarctg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,ZARC_LOC,0,nil)
	local g1=rg:Filter(Card.IsCode,nil,41209827)
	local g2=rg:Filter(Card.IsCode,nil,82044279)
	local g3=rg:Filter(Card.IsCode,nil,16195942)
	local g4=rg:Filter(Card.IsCode,nil,16178681)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	g:Merge(g4)
	if chk==0 then return #g1>0 and #g2>0 and #g3>0 and #g4>0 and Duel.IsExistingMatchingCard(c511010507.zarcspfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,g) and aux.SelectUnselectGroup(g,e,tp,4,4,c511010507.rescon,0) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,4,tp,ZARC_LOC)
end
function c511010507.zarcop(e,tp,eg,ep,ev,re,r,rp)
	local rg=Duel.GetMatchingGroup(aux.NecroValleyFilter(Card.IsAbleToRemove),tp,ZARC_LOC,0,nil):Filter(Card.IsCode,nil,41209827,82044279,16195942,16178681)
	local g=aux.SelectUnselectGroup(rg,e,tp,4,4,c511010507.rescon,1,tp,HINTMSG_REMOVE)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>=4 and g:FilterCount(aux.AND(Card.IsFaceup,Card.IsLocation),nil,LOCATION_REMOVED)>=4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c511010507.zarcspfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g):GetFirst()
		if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 and tc:IsOriginalCode(511009441) then
			tc:CompleteProcedure()
		end
	end
	g:DeleteGroup()
end